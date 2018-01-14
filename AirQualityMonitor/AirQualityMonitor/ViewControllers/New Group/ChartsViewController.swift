//
//  ChartsViewController.swift
//  AirQualityMonitor
//
//  Created by Karol on 11.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Charts
import RxSwift
import RxCocoa
import RxDataSources

class ChartsViewController: UIViewController {

    @IBOutlet weak var lastMeasurementView: UIView!
    @IBOutlet weak var measurementName: UILabel!
    @IBOutlet weak var measurementValue: UILabel!
    @IBOutlet weak var measurementIndex: UILabel!
    @IBOutlet weak var measurementDate: UILabel!
    
    @IBOutlet weak var sensorsCollectionView: UICollectionView!
    @IBOutlet weak var chartView: LineChartView!
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<RxDataSourcesSection<Measurement>>?
    var viewModel: ChartsViewModel!
    var selectedRow = 0
    let bag = DisposeBag()
    
    init(viewModel: ChartsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ChartsViewController.typeName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        setupCollectionView()
        setChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFirstChartData()
    }
    
    func bindData() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        viewModel.displayMeasurement.subscribe(onNext: { measurement in
            self.measurementName.textColor = measurement.indexLevelEnum?.textColor
            self.measurementDate.textColor = measurement.indexLevelEnum?.textColor
            self.measurementValue.textColor = measurement.indexLevelEnum?.textColor
        }).disposed(by: bag)
        viewModel.displayName.bind(to: measurementName.rx.text).disposed(by: bag)
        viewModel.displayDate.bind(to: measurementDate.rx.text).disposed(by: bag)
        viewModel.displayValue.bind(to: measurementValue.rx.text).disposed(by: bag)
        viewModel.displayColor.subscribe(onNext: {
            self.lastMeasurementView.backgroundColor = $0
        }).disposed(by: bag)
        viewModel.chartValues.subscribe(onNext: { items in
            self.setChartData(data: items)
            self.chartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        }).disposed(by: bag)
    }
    
    func setupCollectionView() {
        sensorsCollectionView.backgroundColor = .clear
        sensorsCollectionView.register(UINib(nibName: ChartsCollectionCell.typeName, bundle: nil), forCellWithReuseIdentifier: ChartsCollectionCell.typeName)
        dataSource = RxCollectionViewSectionedReloadDataSource<RxDataSourcesSection<Measurement>>(configureCell: { _, collectionView, index, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartsCollectionCell.typeName, for: index) as? ChartsCollectionCell else { return UICollectionViewCell() }
            cell.configure(measurement: item, isSelected: self.selectedRow == index.row)
            return cell
        })
        viewModel.measurementsSection.bind(to: sensorsCollectionView.rx.items(dataSource: dataSource!)).disposed(by: bag)
        sensorsCollectionView.rx.modelSelected(Measurement.self).subscribe(onNext: { item in
            self.viewModel.fetchChartData(measurement: item)
            self.lastMeasurementView.backgroundColor = item.indexLevelEnum?.colorValue
        }).disposed(by: bag)
        sensorsCollectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.selectedRow = indexPath.row
            self.sensorsCollectionView.reloadData()
        }).disposed(by: bag)
    }
    
    func setChart() {
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
        chartView.highlighter = nil
        chartView.gridBackgroundColor = NSUIColor.white
        chartView.legend.enabled = false
        viewModel.fetchFirstChartData()
    }
    
    func setChartData(data: [SensorDataRead]) {
        let chartEntryData = data.enumerated().map { ChartDataEntry(x: Double($0.offset), y: $0.element.value ?? 0) }
        configureXAxis(dateArray: data.map { $0.date?.toChartDateFormat() ?? "" })
        let data = LineChartData()
        let dataSource = LineChartDataSet(values: chartEntryData, label: "")
        dataSource.circleRadius = 0
        dataSource.colors = [.red]
        
        data.dataSets = [dataSource]
        data.addDataSet(dataSource)
        chartView.data = data
    }
    
    func configureXAxis(dateArray: [String]) {
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateArray)
        chartView.xAxis.avoidFirstLastClippingEnabled = false
        chartView.xAxis.labelWidth = 50.0
    }
    
    @objc
    func goBack() {
        viewModel.flowDelegate.backToParent()
    }
}
