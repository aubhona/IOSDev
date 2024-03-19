//
//  ViewController.swift
//  Practice8
//
//  Created by Aubkhon Abdullaev on 19.03.2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var brandCollectionView: UICollectionView!
    var brands: [String] = ["Adidas", "Asics", "Blueberry", "Calvin", "Cartier", "Cavalli", "Chanel", "Converse"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        brandCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        brandCollectionView.register(BrandCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        brandCollectionView.dataSource = self
        brandCollectionView.delegate = self
        brandCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(brandCollectionView)
        brandCollectionView.pinCenterY(to: view)
        brandCollectionView.pinHorizontal(to: view)
        brandCollectionView.setHeight(105)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let brandCell = cell as? BrandCollectionViewCell else { return cell }
        brandCell.configure(with: brands[indexPath.row])
        return brandCell
    }
}

