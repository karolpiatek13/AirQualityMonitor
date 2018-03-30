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
    @IBOutlet weak var airStatusViewUpConstraint: NSLayoutConstraint!
    
    
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
        viewModel.getStationSensors()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back".localized, style: .plain, target: self, action: #selector(goBack))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAnimations()
    }

    func setupData() {
        lastupDateTitle.text = "lastupDateTitle".localized
        airStatusTitle.text = "airStatusTitle".localized
        viewModel.stationName.asObservable().bind(to: stationNameLanel.rx.text).disposed(by: bag)
        viewModel.lastupDate.asObservable().bind(to: lastupDateLabel.rx.text).disposed(by: bag)
        viewModel.airStatus.asObservable().subscribe(onNext: { status in
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
            cell.alpha = 0
            return cell
        })
        viewModel.measurementsSection.bind(to: collectionView.rx.items(dataSource: dataSource!)).disposed(by: bag)
    }
    
    func setupAnimations() {
        stationNameLanel.alpha = 0
        lastupDateTitle.alpha = 0
        lastupDateLabel.alpha = 0
        
        airStatusView.alpha = 0
        airStatusViewUpConstraint.constant -= 30
    }
    
    func addAnimations() {
        UIView.animate(withDuration: 0.7) {
            self.stationNameLanel.alpha = 1
            self.lastupDateTitle.alpha = 1
            self.lastupDateLabel.alpha = 1
        }
        self.airStatusViewUpConstraint.constant += 30
        UIView.animate(withDuration: 1.0, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0,
            animations: {
                self.airStatusView.alpha = 1
                self.view.layoutIfNeeded()
        })
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

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0.4 + 0.05 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }
}
