//
//  WishCalendarViewController.swift
//  WishMakerApp
//
//  Created by Aubkhon Abdullaev on 06.02.2024.
//

import UIKit
import CoreData

final class WishCalendarViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let contentInset: UIEdgeInsets  = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let collectionTop: Double = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WishMakerViewController.backColor
        configureCollection()
        configureAddButton()
    }
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        /* Temporary line */
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.collectionTop)
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
        }
        /* Temporary line */
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseIdentifier
        )
    }
    
    // MARK: - Add Button Configuration
    private func configureAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWishEventTapped))
        self.navigationItem.rightBarButtonItem = addButton 
    }

    
    @objc private func addWishEventTapped() {
        let wishStore = WishEventCreationView()
        wishStore.modalPresentationStyle = .pageSheet
        wishStore.isModalInPresentation = false
        present(wishStore, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        WishEventCell.reuseIdentifier, for: indexPath)
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        
        
        let wishEvent = WishEventModel(title: "Test", descriptionText: "Test description", startDate: Date(), endDate: Date())
        
        wishEventCell.configure(
            with: wishEvent
            
        )
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // TODO: Adjust cell size as needed
        return CGSize(width: collectionView.bounds.width - 10, height: 150)
    }
    
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
