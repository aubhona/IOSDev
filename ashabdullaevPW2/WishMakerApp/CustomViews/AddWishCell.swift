//
//  AddWishCell.swift
//  WishMakerApp
//
//  Created by Aubkhon Abdullaev on 31.10.2023.
//

import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    // MARK: - Constants
    private enum Constants {
        static let cellBackgroundColor: UIColor = .clear
        static let cellSelectionStyle: UITableViewCell.SelectionStyle = .none
        
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetH: CGFloat = 10
        static let wrapHeight: Double = 150;
        static let wrapBackgroundColor: UIColor = .clear;
        
        static let wishTextTop: Double = 10;
        static let wishTextRadius: Double = 10;
        static let wishTextHeight: Double = 100;
        static let wishTextPlaceHolder: String = "Write your wish here!\nFor editig and deleting wish just select it in list below.\nAfter editing just press submit.\nFor delete: select, delete and press submit."
        static let wishTextPlacegolderColor: UIColor = .lightGray
        static let wishTextColor: UIColor = .black
        
        static let addWishButtonTop: Double = 5;
        static let addWishButtonTitle: String = "Submit";
        static let addWishButtonRadius: Double = 10;
        static let addWishButtonWidth: Double = 70;
        static let addWishButtonHeight: Double = 25;
        static let addWishButtonBackgroundColor: UIColor = .blue
    }
    
    private let wishText: UITextView = UITextView()
    private let addWishButton: UIButton = UIButton(type: .system)
    private var addWish: ((String) -> ())?
    public var wishContent : String {
        get {
            wishText.text
        }
        set (newText) {
            wishText.text = newText
        }
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = Constants.cellSelectionStyle
        backgroundColor = Constants.cellBackgroundColor
        
        let wrap: UIView = UIView()
        
        contentView.addSubview(wrap)
        wrap.pin(to: contentView);
        
        wrap.setHeight(Constants.wrapHeight)
        wrap.isUserInteractionEnabled = true
        wrap.backgroundColor = Constants.wrapBackgroundColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.addSubview(wishText)
        wrap.addSubview(addWishButton)
        
        configureWishText(wrap: wrap)
        configureAddWishButton()
    }
    
    private func configureWishText(wrap: UIView) {
        wishText.pinHorizontal(to: wrap, Constants.wrapOffsetH)
        wishText.pinTop(to: wrap, Constants.wishTextTop)
        wishText.setHeight(Constants.wishTextHeight)
        wishText.layer.cornerRadius = Constants.wishTextRadius
        wishText.text = Constants.wishTextPlaceHolder
        wishText.textColor = Constants.wishTextPlacegolderColor
        wishText.delegate = self
    }
    
    private func configureAddWishButton() {
        addWishButton.setTitle(Constants.addWishButtonTitle, for: .normal)
        addWishButton.setTitleColor(.white, for: .normal)
        addWishButton.backgroundColor = Constants.addWishButtonBackgroundColor
        addWishButton.layer.cornerRadius = Constants.addWishButtonRadius
        addWishButton.pinTop(to: wishText.bottomAnchor, Constants.addWishButtonTop)
        addWishButton.pinRight(to: wishText)
        addWishButton.setWidth(Constants.addWishButtonWidth)
        addWishButton.setHeight(Constants.addWishButtonHeight)
        addWishButton.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
    }
    
    @objc func addWishButtonTapped() {
        addWish?(wishText.text)
        wishText.text = String()
    }
    
    func configure(action: @escaping (String) -> ()) {
        addWish = action;
    }
}

// MARK: - UITextViewDelegate
extension AddWishCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if wishText.textColor != Constants.wishTextPlacegolderColor {
            return
        }
        wishText.text = nil
        wishText.textColor = Constants.wishTextColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !wishText.text.isEmpty {
            return
        }
        wishText.text = Constants.wishTextPlaceHolder
        wishText.textColor = Constants.wishTextPlacegolderColor
    }
}
