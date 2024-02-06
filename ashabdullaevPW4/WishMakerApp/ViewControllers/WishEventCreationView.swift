//
//  WishEventCreationView.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 28.01.2024.
//

import UIKit

import UIKit

class WishEventCreationView: UIViewController {
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
        
        static let writtenWishSectionIndex: Int = 1;
        
        static let wishSectionHeaderTitle: String = "Your wishes:"
        
        static let wishesKey: String = "WishArrayKey"
    }
    
    // MARK: - UI elements
    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    private var closeButton: UIButton = UIButton(type: .custom)
    private var saveButton: UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.viewBackgroundColor
        
        // Создание меток
        let titleLabel = createLabel(withText: "Event Title:")
        let descriptionLabel = createLabel(withText: "Event Description:")
        let startDateLabel = createLabel(withText: "Start Date:")
        let endDateLabel = createLabel(withText: "End Date:")
        
        configureTextField(titleTextField, placeholder: "Enter event title")
        configureTextField(descriptionTextField, placeholder: "Enter event description")
        
        configureDatePicker(startDatePicker, selector: #selector(startDateChanged(_:)))
        configureDatePicker(endDatePicker, selector: #selector(endDateChanged(_:)))
        
        // Добавляем метки и поля в stackView
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, titleTextField,
            descriptionLabel, descriptionTextField,
            startDateLabel, startDatePicker,
            endDateLabel, endDatePicker
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        configureCloseButton()
        configureSaveButton() // Добавление кнопки сохранения
    }
    
    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
    }
    
    private func configureDatePicker(_ datePicker: UIDatePicker, selector: Selector) {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: selector, for: .valueChanged)
    }
    
    private func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    @objc private func startDateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        print("Start Date: \(formatter.string(from: sender.date))")
    }
    
    @objc private func endDateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        print("End Date: \(formatter.string(from: sender.date))")
    }
    
    // MARK: - Configure close button
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
    
    // MARK: - Configure save button
    private func configureSaveButton() {
        view.addSubview(saveButton)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .blue // Установите цвет кнопки по вашему желанию
        saveButton.layer.cornerRadius = Constants.wishTableCornerRadius
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        // Установка констрейнтов для кнопки сохранения
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 40) // Высота кнопки
        ])
    }
    
    @objc func saveTapped() {
        // Обработка нажатия на кнопку сохранения
    }
    
}
