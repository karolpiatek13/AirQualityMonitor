//
//  StationListViewController.swift
//  AirQualityMonitor
//
//  Created by Karol on 08.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class StationListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: StationListViewModel!
    var dataSource: RxTableViewSectionedReloadDataSource<RxDataSourcesSection<Station>>?
    let bag = DisposeBag()
    
    init(viewModel: StationListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: StationListViewController.typeName, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupTableView()
        setupSearchBar()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: StationCell.typeName, bundle: nil), forCellReuseIdentifier: StationCell.typeName)
        dataSource = RxTableViewSectionedReloadDataSource<RxDataSourcesSection<Station>>(configureCell: { _, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StationCell.typeName, for: indexPath) as? StationCell else { return UITableViewCell() }
            cell.bag = DisposeBag()
            cell.configure(station: item)
            cell.arrowButton.rx.tap.subscribe(onNext: {
                self.viewModel.showStation(station: item)
            }).disposed(by: cell.bag)
            return cell
        })
        guard let dataSource = dataSource else { return }
        viewModel.stationsShownSection.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: bag)
    }
    
    func setupSearchBar() {
        viewModel.stationsSection.sample(searchBar.rx.text)
            .debounce(0.5, scheduler: MainScheduler.instance)
            .subscribe({
                switch $0 {
                case let .next(sections):
                    let shownSections = sections.map { section in
                        return RxDataSourcesSection<Station>(header: "", items: section.items.filter {
                            if self.searchBar.text != "" {
                                guard let name = $0.city?.name,
                                    let searchText = self.searchBar.text else { return false }
                                return name.lowercased().contains(searchText.lowercased())
                            }
                            return true
                        })
                    }
                    self.viewModel.stationsShownSection.onNext(shownSections)
                    self.viewModel.stationsSection.onNext(sections)
                default:
                    break
                }
            }).disposed(by: bag)
    }
}
