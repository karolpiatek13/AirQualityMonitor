//
//  StationListViewController.swift
//  AirQualityMonitor
//
//  Created by Karol on 08.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class StationListViewController: UIViewController {

    var viewModel: StationListViewModel!
    
    init(viewModel: StationListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: StationListViewController.typeName, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
