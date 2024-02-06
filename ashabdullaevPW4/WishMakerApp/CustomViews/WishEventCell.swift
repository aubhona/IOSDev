// WishEventCell.swift
// WishMakerApp

import UIKit

final class WishEventCell: UICollectionViewCell {
    static let reuseIdentifier: String = "WishEventCell"
    
    // MARK: - Constants
    private enum Constants {
        static let cellCornerRadius: CGFloat = 12
        static let cellMargin: CGFloat = 16
        static let cellBackgroundColor: UIColor = .white
        static let titleFont: UIFont = .boldSystemFont(ofSize: 18)
        static let descriptionFont: UIFont = .systemFont(ofSize: 14)
        static let dateFont: UIFont = .italicSystemFont(ofSize: 12)
        static let titleColor: UIColor = .darkGray
        static let descriptionColor: UIColor = .gray
        static let dateColor: UIColor = .lightGray
    }
    
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    @available(iOS 15.0, *)
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start: \(event.startDate.formatted())"
        endDateLabel.text = "End: \(event.endDate.formatted())"
        layoutIfNeeded()
    }
    
    // MARK: - UI Setup
    private func setupCell() {
        contentView.layer.cornerRadius = Constants.cellCornerRadius
        contentView.backgroundColor = Constants.cellBackgroundColor
        contentView.clipsToBounds = true
    }
    
    private func setupWrapView() {
        contentView.addSubview(wrapView)
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.cellMargin),
            wrapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.cellMargin),
            wrapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.cellMargin),
            wrapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.cellMargin)
        ])
        
        wrapView.layer.cornerRadius = Constants.cellCornerRadius
        wrapView.backgroundColor = Constants.cellBackgroundColor
        wrapView.clipsToBounds = true
    }
    
    private func setupTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: Constants.cellMargin),
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.cellMargin),
            titleLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.cellMargin)
        ])
        
        titleLabel.font = Constants.titleFont
        titleLabel.textColor = Constants.titleColor
    }
    
    private func setupDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.cellMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.cellMargin)
        ])
        
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.textColor = Constants.descriptionColor
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            startDateLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.cellMargin),
            startDateLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.cellMargin)
        ])
        
        startDateLabel.font = Constants.dateFont
        startDateLabel.textColor = Constants.dateColor
    }
    
    private func setupEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Adjust this to position endDateLabel below startDateLabel
            endDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 8),
            endDateLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.cellMargin),
            endDateLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.cellMargin)
        ])
        
        endDateLabel.font = Constants.dateFont
        endDateLabel.textColor = Constants.dateColor
    }
}
