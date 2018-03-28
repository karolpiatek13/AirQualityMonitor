//
//  AirQualityViewController.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class AirQualityIndexViewController: UIViewController {
    
    @IBOutlet weak var stationNameLanel: UILabel!
    @IBOutlet weak var lastupDateLabel: UILabel!
    @IBOutlet weak var airStatusView: UIView!
    @IBOutlet weak var airStatusValueLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lastupDateTitle: UILabel!
    @IBOutlet weak var airStatusTitle: UILabel!
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<RxDataSourcesSection<Measurement>>?
    var viewModel: AirQualityViewModel!
    let bag = DisposeBag()
    
    init(viewModel: AirQualityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: AirQualityIndexViewController.typeName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupCollectionView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back".localized, style: .plain, target: self, action: #selector(goBack))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getStationSensors()
    }
    
    func setupData() {
        lastupDateTitle.text = "lastupDateTitle".localized
        airStatusTitle.text = "airStatusTitle".localized
        viewModel.stationName.asObservable().bind(to: stationNameLanel.rx.text).disposed(by: bag)
        viewModel.lastupDate.bind(to: lastupDateLabel.rx.text).disposed(by: bag)
        viewModel.airStatus.subscribe(onNext: { status in
            self.airStatusValueLabel.text = status.textValue
            self.airStatusValueLabel.textColor = status.textColor
            self.airStatusView.backgroundColor = status.colorValue
        }).disposed(by: bag)
    }

    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: MeasurementCell.typeName, bundle: nil), forCellWithReuseIdentifier: MeasurementCell.typeName)
        collectionView.rx.setDelegate(self).disposed(by: bag)
        dataSource = RxCollectionViewSectionedReloadDataSource<RxDataSourcesSection<Measurement>>(configureCell: { _, collectionView, index, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeasurementCell.typeName, for: index) as? MeasurementCell else { return UICollectionViewCell() }
            cell.configure(measurement: item)
            return cell
        })
        viewModel.measurementsSection.bind(to: collectionView.rx.items(dataSource: dataSource!)).disposed(by: bag)
    }
    
    @objc
    func goBack() {
        viewModel.flowDelegate.backToParent()
    }
}

extension AirQualityIndexViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = collectionView.frame.size.width
        width *= width / 3 > 100 ? 0.31 : 0.48
        return CGSize(width: width, height: width)
    }
}
