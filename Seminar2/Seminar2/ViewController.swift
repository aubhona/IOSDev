//
//  ViewController.swift
//  Seminar2
//
//  Created by Aubkhon Abdullaev on 22.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let ourView = UIView()
        
        view.addSubview(ourView)
        ourView.backgroundColor = .blue
        
        ourView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ourView.heightAnchor.constraint(equalToConstant: 250),
            ourView.widthAnchor.constraint(equalToConstant: 250),
            ourView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ourView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
        
        let otherView = UIView()
        view.addSubview(otherView)
        otherView.pinCentre(to: ourView)
        otherView.pinWidth(to: ourView, mult: 0.5)
        otherView.pinHeight(to: ourView, mult: 0.5)
        otherView.backgroundColor = .darkGray
        
        let anotherView = UIView()
        view.addSubview(anotherView)
        anotherView.pinRight(to: otherView)
        anotherView.pinBottom(to: otherView)
        anotherView.setWidth(const: 20)
        anotherView.setHeight(const: 20)
        anotherView.backgroundColor = .black
        
        let anotherView1 = UIView()
        view.addSubview(anotherView1)
        anotherView1.pinRight(to: otherView, const: 10)
        anotherView1.pinTop(to: otherView, const: 10)
        anotherView1.pinWidth(to: otherView, mult: 0.5)
        anotherView1.pinHeight(to: otherView, mult: 0.5)
        anotherView1.backgroundColor = .red
        
        let anotherView2 = UIView()
        view.addSubview(anotherView2)
        anotherView2.pinLeft(to: otherView)
        anotherView2.pinBottom(to: otherView, const: 20)
        anotherView2.pinWidth(to: otherView, mult: 0.25)
        anotherView2.pinHeight(to: otherView, mult: 0.25)
        anotherView2.backgroundColor = .purple
    }
    
}

