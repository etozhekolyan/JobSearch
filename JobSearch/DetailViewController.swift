//
//  DetailViewController.swift
//  JobSearch
//
//  Created by Nickolay Vasilchenko on 20.11.2023.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    let detailView = DetalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = detailView
    }
}
