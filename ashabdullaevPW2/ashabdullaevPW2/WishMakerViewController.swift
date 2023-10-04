//
//  WishMakerViewController.swift
//  ashabdullaevPW2
//
//  Created by Aubkhon Abdullaev on 03.10.2023.
//

import UIKit

final class WishMakerViewController: UIViewController {
    enum Constants {
        static let titleText: String = "WishMaker"
        static let titleBackgroundColor = "#FFFFF0"
        static let titleFontSize: CGFloat = 32
        static let titleTop: CGFloat = 30
        
        static let descriptionText: String = "WishMaker change color of your life!"
        static let descriptionColor : String = "#E5FCC2"
        static let descriptionLeft : CGFloat = 20
        static let descriptionTop : CGFloat = 20
        static let descriptionFontSize : CGFloat = 16
        
    }
    
    private var titleView: UILabel = UILabel()
    private var descrptionView : UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(UIColor.generateRandomHexColor());
        
        configureTittle()
        configureDescription()
        configureSliders()
    }
    
    private func configureTittle() {
        titleView.text = Constants.titleText
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleView.textColor = UIColor(Constants.titleBackgroundColor);
        
        view.addSubview(titleView)
        titleView.pinCenterX(to: view)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    private func configureDescription() {
        descrptionView.text = Constants.descriptionText
        descrptionView.font = UIFont.boldSystemFont(ofSize: Constants.descriptionFontSize)
        descrptionView.textColor = UIColor(Constants.descriptionColor);
        
        view.addSubview(descrptionView)
        descrptionView.pinCenterX(to: view)
        descrptionView.pinLeft(to: view, Constants.descriptionLeft)
        descrptionView.pinTop(to: view.bottomAnchor, Constants.descriptionTop)
    }
    
    private func configureSliders() {
        let stack = UIStackView()
        stack.backgroundColor = UIColor(UIColor.generateRandomHexColor())
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = 20
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: "Red", min: 0, max: 1)
        let sliderBlue = CustomSlider(title: "Blue", min: 0, max: 255)
        let sliderGreen = CustomSlider(title: "Green", min: 0, max: 255)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(UIColor.generateRandomHexColor())
        }
    }
}
