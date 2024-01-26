//
//  ViewController.swift
//  CustomNetworking
//
//  Created by Aubkhon Abdullaev on 18.01.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ArticlesWorker().fetchNews(page: 1, completion: { result in
            print(result)
        })
    }
}

