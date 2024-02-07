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
        static let cellHeight: Double = 150
    }
    
    // MARK: - Fields
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private var calendarManager: CalendarManager = CalendarManager()
    private var addButton: UIBarButtonItem = UIBarButtonItem()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WishMakerViewController.backColor
        configureCollection()
        configureAddButton()
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.collectionTop)
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = .zero
            layout.minimumLineSpacing = .zero
            layout.invalidateLayout()
        }
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
    }
    
    // MARK: - Add Button Configuration
    private func configureAddButton() {
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWishEventTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    
    @objc private func addWishEventTapped() {
        let wishEventCreate = WishEventCreationView()
        wishEventCreate.modalPresentationStyle = .pageSheet
        wishEventCreate.isModalInPresentation = false
        wishEventCreate.onSave = { [weak self] event in
            if (!(self?.calendarManager.create(eventModel: event) ?? false)) {
                print("Error while saving event to the Calendar")
            }
            self?.collectionView.reloadData()
            
        }
        present(wishEventCreate, animated: true, completion: nil)
    }
}


// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return CoreDataEventManager.shared.fetchWish().count
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
        
        guard let wishEvent = CoreDataEventManager.shared.fetchWish(id: indexPath.row) else {
            return cell
        }
        
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
        return CGSize(width: collectionView.bounds.width - Constants.collectionTop, height: Constants.cellHeight)
    }
    
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WishEventCell else { return }
        cell.wrapView.backgroundColor = .cyan
        print("Cell tapped at index \(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WishEventCell else { return }
        cell.wrapView.backgroundColor = .clear
    }
}
