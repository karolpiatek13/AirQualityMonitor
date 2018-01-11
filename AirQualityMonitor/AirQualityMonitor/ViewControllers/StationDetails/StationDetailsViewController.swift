//
//  StationDetailsViewController.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class StationDetailsViewController: UIViewController {

    var viewModel: StationDetailsViewModel!
    
    init(viewModel: StationDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: StationDetailsViewController.typeName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
    }
    
    @objc
    func goBack() {
        viewModel.flowDelegate.backToParent()
    }
}
