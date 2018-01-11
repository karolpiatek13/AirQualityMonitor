//
//  ChartsViewController.swift
//  AirQualityMonitor
//
//  Created by Karol on 11.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import UIKit

class ChartsViewController: UIViewController {

    var viewModel: ChartsViewModel!
    
    init(viewModel: ChartsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ChartsViewController.typeName, bundle: nil)
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
        
    }
}
