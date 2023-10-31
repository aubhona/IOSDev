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
    }
    
    private var wishTable: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(wishTable)
        wishTable.backgroundColor = .red
        wishTable.dataSource = self
        wishTable.separatorStyle = .none
        wishTable.layer.cornerRadius = Constants.wishTableCornerRadius
        
        wishTable.pin(to: view, Constants.wishTableOffset)
        wishTable.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
        
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        
        wishCell.configure(with: wishArray[indexPath.row])
        
        return wishCell
    }
}
