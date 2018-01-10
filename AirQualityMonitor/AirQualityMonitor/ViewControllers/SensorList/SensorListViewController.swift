//
//  SensorListViewController.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class SensorListViewController: UIViewController {

    var viewModel: SensorListViewModel!
    
    init(viewModel: SensorListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: SensorListViewController.typeName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
