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
        static let viewBackgroundColor: UIColor = UIColor("#B2DFDB")
        
        static let wishTableCornerRadius: Double = 20
        static let wishTableOffset: Double = 20
        static let wishTableNumberOfSection: Int = 2;
        static let wishTableBackgroundColor: UIColor = UIColor("#B2DFDB");
        static let wishTableSeparatorStyle: UITableViewCell.SeparatorStyle = .none;
        
        static let closeButtonImage: UIImage = UIImage(named: "CloseButton") ?? UIImage()
        static let closeButtonTop: Double = 3
        static let closeButtonLeft: Double = 3
        static let closeButtonWidth: Double = 27
        static let closeButtonHeight: Double = 27
        
        static let addWishCellAmount: Int = 1;
        static let addWishSectionIndex: Int = 0;
        static let addWishSectionHeaderTitle: String = "Write, edit, delete your wish:"
        
        static let wishSectionHeaderTitle: String = "Your wishes:"
        
        static let wishesKey: String = "WishArrayKey"
    }
    
    // MARK: - Fields
    private let defaults = UserDefaults.standard
    private var wishTable: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = []
    private var wishSelected: ((IndexPath) -> ())?
    private var lastSelectedWish: IndexPath?
    private var closeButton = UIButton(type: .custom)
    
    // MARK: - Configure
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.viewBackgroundColor
        
        configureTable()
        configureCloseButton()
        
        wishArray = defaults.array(forKey: Constants.wishesKey) as? [String] ?? [];
    }
    
    private func configureTable() {
        view.addSubview(wishTable)
        
        wishTable.backgroundColor = Constants.wishTableBackgroundColor
        wishTable.dataSource = self
        wishTable.delegate = self
        wishTable.separatorStyle = Constants.wishTableSeparatorStyle
        wishTable.layer.cornerRadius = Constants.wishTableCornerRadius
        
        wishTable.pin(to: view, Constants.wishTableOffset)
        wishTable.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        wishTable.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    private func configureCloseButton() {
        view.addSubview(closeButton)
        
        closeButton.setImage(Constants.closeButtonImage, for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.pinTop(to: view, Constants.closeButtonTop)
        closeButton.pinLeft(to: view, Constants.closeButtonLeft)
        closeButton.setWidth(Constants.closeButtonWidth)
        closeButton.setHeight(Constants.closeButtonHeight)
    }
    
    @objc func closeTapped() {
        dismiss(animated: true)
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
                if wish.isEmpty {
                    return;
                }
                self?.wishArray.append(wish)
                self?.wishTable.reloadData()
                self?.defaults.set(self?.wishArray, forKey: Constants.wishesKey)
            })
            
            wishSelected = {[weak addWishCell, weak self] indexPath in
                addWishCell?.textViewDidBeginEditing(UITextView())
                if self?.lastSelectedWish == nil {
                    addWishCell?.wishContent = String()
                    return
                }
                guard let cell = tableView.cellForRow(at: indexPath) as? WrittenWishCell else { return }
                addWishCell?.wishContent = cell.wishText;
                addWishCell?.configure(action: {[weak self, indexPath] wish in
                    if self?.lastSelectedWish == nil {
                        return
                    }
                    if wish.isEmpty {
                        self?.wishArray.remove(at: indexPath.row)
                    } else {
                        self?.wishArray[indexPath.row] = wish
                    }
                    self?.lastSelectedWish = nil;
                    self?.wishTable.deselectRow(at: indexPath, animated: true)
                    self?.wishTable.reloadData()
                    self?.defaults.set(self?.wishArray, forKey: Constants.wishesKey)})
            }
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

// MARK: - UITableViewDelegate
extension WishStoringViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if lastSelectedWish != nil && lastSelectedWish == indexPath {
            tableView.deselectRow(at: indexPath, animated: true)
            lastSelectedWish = nil
            wishSelected?(indexPath)
            return
        }
        lastSelectedWish = indexPath;
        wishSelected?(indexPath)
    }
}
