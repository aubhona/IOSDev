//
//  ViewController.swift
//  collectionViewTest
//
//  Created by Aubkhon Abdullaev on 20.10.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView : UICollectionView!
    
    
    let cellId = "Cell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyCell;
        cell.myTextLabel1.text = "Distance"
        cell.myTextLabel2.text = String(indexPath.row + 1) + " m"
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.backgroundColor = .white
        return cell;
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
        layout.itemSize = CGSize(width: (view.frame.width ) / 2, height: view.frame.height / 10)
        
        let rect = CGRect(x: 5, y: 5, width: view.frame.width , height: view.frame.height)
        
        collectionView = UICollectionView(frame: rect, collectionViewLayout: layout) // self.view.frame
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = UIColor.lightGray //black
        collectionView.translatesAutoresizingMaskIntoConstraints = false //
        collectionView.layer.cornerRadius = 35
        collectionView.layer.masksToBounds = true
        
        self.view.addSubview(collectionView)
    }
}

