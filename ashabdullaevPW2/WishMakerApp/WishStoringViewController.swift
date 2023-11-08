//
//  WishStoringViewController.swift
//  WishMakerApp
//
//  Created by Aubkhon Abdullaev on 30.10.2023.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let wishTableCornerRadius: Double = 15
        static let wishTableOffset: Double = 30
        static let wishTableNumberOfSection: Int = 2;
        
        static let addWishCellAmount: Int = 1;
        static let addWishSectionIndex: Int = 0;
        static let addWishSectionHeaderTitle: String = "Напишите своё желание: "
        
        static let wishSectionHeaderTitle: String = "Ваши желания: "
        
        static let wishesKey: String = "WishKey"
    }
    
    private let defaults = UserDefaults.standard
    private var wishTable: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureTable()
        
        wishArray = defaults.array(forKey: Constants.wishesKey) as? [String] ?? [];
    }
    
    private func configureTable() {
        view.addSubview(wishTable)
        wishTable.backgroundColor = .red
        wishTable.dataSource = self
        wishTable.separatorStyle = .none
        wishTable.layer.cornerRadius = Constants.wishTableCornerRadius
        
        wishTable.pin(to: view, Constants.wishTableOffset)
        wishTable.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        wishTable.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Constants.addWishSectionIndex {
            return Constants.addWishCellAmount;
        }
        
        return wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Constants.addWishSectionIndex {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            
            guard let addWishCell = cell as? AddWishCell else { return cell }
            
            addWishCell.configure(action: {[weak self] wish in
                self?.wishArray.append(wish)
                self?.wishTable.reloadData()
                self?.defaults.set(self?.wishArray, forKey: Constants.wishesKey)
            })
            
            return addWishCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
        
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        
        wishCell.configure(with: wishArray[indexPath.row])
        
        return wishCell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == Constants.addWishSectionIndex {
            return Constants.addWishSectionHeaderTitle;
        }
        return Constants.wishSectionHeaderTitle
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.wishTableNumberOfSection
    }
}
