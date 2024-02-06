// WishEventCell.swift
// WishMakerApp

import UIKit

final class WishEventCell: UICollectionViewCell {
    static let reuseIdentifier: String = "WishEventCell"
    
    // MARK: - Constants
    private enum Constants {
        static let cellCornerRadius: CGFloat = 12
        static let cellMargin: CGFloat = 16
        static let cellBackgroundColor: UIColor = .clear
        
        static let titleFont: UIFont = .boldSystemFont(ofSize: 18)
        static let titleColor: UIColor = .darkGray
        
        static let descriptionFont: UIFont = .systemFont(ofSize: 14)
        static let descriptionColor: UIColor = .gray
        
        static let dateFont: UIFont = .italicSystemFont(ofSize: 12)
        static let dateColor: UIColor = .lightGray
        
        static let shadowOpacity: Float = 0.1
        static let shadowRadius: CGFloat = 10
        static let shadowOffset: CGSize = CGSize(width: 3, height: 3)
        static let shadowColor: CGColor = UIColor.black.cgColor
        
        static let wrapColor: UIColor = .clear
        static let wrapCornerRadius: CGFloat = 12
        static let wrapBorderWidth: CGFloat = 1
        static let wrapBorderColor: CGColor = UIColor.lightGray.cgColor
        
        static let elementVerticalSpacing: CGFloat = 8
    }
    
    // MARK: - UI Elements
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupWrapView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupStartDateLabel()
        setupEndDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.descriptionText
        startDateLabel.text = "Start: \(formatDate(event.startDate))"
        endDateLabel.text = "End: \(formatDate(event.endDate))"
        layoutIfNeeded()
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    // MARK: - UI Configuration
    private func setupCell() {
        contentView.layer.cornerRadius = Constants.cellCornerRadius
        contentView.backgroundColor = Constants.cellBackgroundColor
        contentView.clipsToBounds = true
    }
    
    private func setupWrapView() {
        contentView.addSubview(wrapView)
        backgroundColor = Constants.wrapColor
        wrapView.backgroundColor = Constants.wrapColor
        wrapView.layer.cornerRadius = Constants.wrapCornerRadius
        wrapView.layer.borderWidth = Constants.wrapBorderWidth
        wrapView.layer.borderColor = Constants.wrapBorderColor
        wrapView.layer.shadowOpacity = Constants.shadowOpacity
        wrapView.layer.shadowRadius = Constants.shadowRadius
        wrapView.layer.shadowOffset = Constants.shadowOffset
        wrapView.layer.shadowColor = Constants.shadowColor
        wrapView.pin(to: contentView, Constants.cellMargin)
        wrapView.clipsToBounds = false
    }
    
    private func setupTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.pinTop(to: wrapView, Constants.cellMargin)
        titleLabel.pinHorizontal(to: wrapView, Constants.cellMargin)
        titleLabel.font = Constants.titleFont
        titleLabel.textColor = Constants.titleColor
    }
    
    private func setupDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.elementVerticalSpacing)
        descriptionLabel.pinHorizontal(to: wrapView, Constants.cellMargin)
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.textColor = Constants.descriptionColor
        descriptionLabel.numberOfLines = .zero
    }
    
    private func setupStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, Constants.elementVerticalSpacing)
        startDateLabel.pinHorizontal(to: wrapView, Constants.cellMargin)
        startDateLabel.font = Constants.dateFont
        startDateLabel.textColor = Constants.dateColor
    }
    
    private func setupEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Constants.elementVerticalSpacing)
        endDateLabel.pinHorizontal(to: wrapView, Constants.cellMargin)
        endDateLabel.font = Constants.dateFont
        endDateLabel.textColor = Constants.dateColor
    }
}
