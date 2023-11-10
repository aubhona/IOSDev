//
//  WishMakerViewController.swift
//  ashabdullaevPW2
//
//  Created by Aubkhon Abdullaev on 03.10.2023.
//

import UIKit

final class WishMakerViewController: UIViewController, UIColorPickerViewControllerDelegate {
    // MARK: - Constants
    enum Constants {
        static let titleText: String = "WishMaker"
        static let titleBackgroundColor: UIColor = UIColor("#FFFFF0")
        static let titleFontSize: CGFloat = 32
        static let titleTop: CGFloat = 30
        
        static let descriptionText: String = "This app will bring your joy and will fulfill three of your wishes!\n\t- The first is to change the background color."
        static let descriptionColor: UIColor = UIColor("#E5FCC2")
        static let descriptionLeft: CGFloat = 20
        static let descriptionTop: CGFloat = 20
        static let descriptionFontSize: CGFloat = 16
        static let descriptionNumberOfLines: Int = 0
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let alpha: String = "Alpha"
        
        static let alphaDefaultValue : Float = 0.5
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = 40
        static let stackLeading: CGFloat = 20
        
        static let buttonBottom: CGFloat = 20
        
        static let redSliderInd: Int = 0
        static let greenSliderInd: Int = 1
        static let blueSliderInd: Int = 2
        static let alphaSliderInd: Int = 3
        
        static let slidersHiddenSwitchText: String = "Sliders"
        static let alphaHiddenSwitchText: String = "Alpha"
        
        static let switchesStackWidth: Double = 75
        static let switchesStackLeft: Double = 25
        
        static let animationDuration: Double = 0.45
        
        static let randomColorButtonText: String = "Random"
        static let randomColorButtonCornerRadius: Double = 10
        static let randomColorButtonLeft: Double = 20
        static let randomColorButtonBottom: Double = 10
        static let randomColorButtonWidth: Double = 75
        
        static let colorPickerCornerRadius: Double = 10
        static let colorPickerCornerWidth: Double = 75
        static let colorPickerCornerBottom: Double = 10
        static let colorPickerCornerLeft: Double = 20
        static let colorPickerText: String = "Select"
        
        static let wishButtonHeight: Double = 35
        static let wishButtonCornerRadius: Double = 15
        static let wishButtonBottom: Double = 50
        static let wishButtonSide: Double = 25
        static let wishButtonText: String = "My wishes"
        static let wishButtonBackgroundColor: UIColor = UIColor("#AED6F1")
        static let wishButtonTitleColor: UIColor = .black
        
    }
    
    // MARK: - Fields
    private var titleLabel: UILabel = UILabel()
    private var descrptionLabel : UILabel = UILabel()
    private var slidersStack: UIStackView = UIStackView()
    private var switchesStack: UIStackView = UIStackView()
    private var randomColorButton : UIButton = UIButton(type: .system)
    private var colorPickerButton : UIButton = UIButton(type: .system)
    private var backgroundColorChanged : (() -> (Void))?
    private var addWishButton: UIButton = UIButton(type: .system)
    
    // MARK: - Configure main view
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        configureTitle()
        configureDescription()
        configureAddWishButton()
        configureSliders()
        configureSwitches()
        configureButtonRandomColor()
        configureColorPickerButton()
    }
    
    // MARK: - Configure title
    private func configureTitle() {
        titleLabel.text = Constants.titleText
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = Constants.titleBackgroundColor;
        
        view.addSubview(titleLabel)
        
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    // MARK: - Configure description
    private func configureDescription() {
        descrptionLabel.text = Constants.descriptionText
        descrptionLabel.font = UIFont.boldSystemFont(ofSize: Constants.descriptionFontSize)
        descrptionLabel.textColor = Constants.descriptionColor;
        descrptionLabel.numberOfLines = Constants.descriptionNumberOfLines
        
        view.addSubview(descrptionLabel)
        
        descrptionLabel.pinCenterX(to: view)
        descrptionLabel.pinLeft(to: view, Constants.descriptionLeft)
        descrptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTop)
    }
    
    // MARK: - Configure sliders
    private func configureSliders() {
        slidersStack.axis = .vertical
        slidersStack.layer.cornerRadius = Constants.stackRadius
        slidersStack.clipsToBounds = true
        slidersStack.isHidden = true
        
        view.addSubview(slidersStack)
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderAlpha = CustomSlider(title: Constants.alpha, min: Constants.sliderMin, max: Constants.sliderMax)
        
        sliderRed.slider.minimumTrackTintColor = .red
        sliderBlue.slider.minimumTrackTintColor = .blue
        sliderGreen.slider.minimumTrackTintColor = .green
        sliderRed.titleView.textColor = .white
        sliderBlue.titleView.textColor = .white
        sliderGreen.titleView.textColor = .white
        sliderAlpha.titleView.textColor = .white
        sliderAlpha.slider.value = Constants.alphaDefaultValue
        
        for slider in [sliderRed, sliderGreen, sliderBlue, sliderAlpha] {
            slidersStack.addArrangedSubview(slider)
            slider.backgroundColor = view.backgroundColor
            slider.valueChanged = { [weak self] in
                self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: CGFloat(sliderAlpha.slider.value))
            }
        }
        
        backgroundColorChanged = {[weak sliderRed, weak sliderGreen, weak sliderBlue, weak sliderAlpha, weak self] in
            sliderRed?.slider.value = Float(self?.view.backgroundColor?.cgColor.components?[Constants.redSliderInd] ?? 0)
            sliderGreen?.slider.value = Float(self?.view.backgroundColor?.cgColor.components?[Constants.greenSliderInd] ?? 0)
            sliderBlue?.slider.value = Float(self?.view.backgroundColor?.cgColor.components?[Constants.blueSliderInd] ?? 0)
            sliderAlpha?.slider.value = Float(self?.view.backgroundColor?.cgColor.components?[Constants.alphaSliderInd] ?? 1)
        }
        
        slidersStack.pinCenterX(to: view)
        slidersStack.pinLeft(to: view, Constants.stackLeading)
        slidersStack.pinBottom(to: addWishButton.topAnchor, Constants.stackBottom)
        
        slidersStack.alpha = CGFloat(Constants.alphaDefaultValue)
        slidersStack.isHidden = true
        
        sliderAlpha.alpha = CGFloat(Constants.alphaDefaultValue)
        sliderAlpha.isHidden = true
        
    }
    
    // MARK: - Configure switches
    private func configureSwitches(){
        switchesStack.layer.cornerRadius = Constants.stackRadius
        switchesStack.clipsToBounds = true
        switchesStack.axis = .vertical
        
        view.addSubview(switchesStack)
        
        switchesStack.setWidth(Constants.switchesStackWidth)
        
        let slidersHiddenSwitch = CustomSwitch(title: Constants.slidersHiddenSwitchText)
        let alphaHiddenSwitch = CustomSwitch(title: Constants.alphaHiddenSwitchText)
        
        alphaHiddenSwitch.alpha = CGFloat(Constants.alphaDefaultValue)
        alphaHiddenSwitch.isHidden = true
        alphaHiddenSwitch.titleLabel.textColor = .white
        slidersHiddenSwitch.titleLabel.textColor = .white
        
        
        for switchView in [alphaHiddenSwitch, slidersHiddenSwitch] {
            switchesStack.addArrangedSubview(switchView)
            switchView.backgroundColor = view.backgroundColor
        }
        
        slidersHiddenSwitch.tapped = {[weak self, weak slidersHiddenSwitch, weak alphaHiddenSwitch] in
            if ((slidersHiddenSwitch?.innerSwitch.isOn ?? true)){
                self?.slidersStack.isHidden = false
                alphaHiddenSwitch?.isHidden = false
            }
            UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self, weak slidersHiddenSwitch] in
                self?.slidersStack.alpha = (slidersHiddenSwitch?.innerSwitch.isOn ?? true) ? 1 : 0
                alphaHiddenSwitch?.alpha = (slidersHiddenSwitch?.innerSwitch.isOn ?? true) ? 1 : 0
            }, completion: {_ in
                if (!(slidersHiddenSwitch?.innerSwitch.isOn ?? true)){
                    self?.slidersStack.isHidden = true
                    alphaHiddenSwitch?.isHidden = true
                }
            })
        }
        
        alphaHiddenSwitch.tapped = {[weak self, weak alphaHiddenSwitch] in
            if ((alphaHiddenSwitch?.innerSwitch.isOn ?? true)){
                self?.slidersStack.arrangedSubviews.last?.isHidden = false
            }
            UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self, weak alphaHiddenSwitch] in
                self?.slidersStack.arrangedSubviews.last?.alpha = (alphaHiddenSwitch?.innerSwitch.isOn ?? true) ? 1 : 0
            }, completion: {_ in
                if (!(alphaHiddenSwitch?.innerSwitch.isOn ?? true)){
                    self?.slidersStack.arrangedSubviews.last?.isHidden = true
                }
            })
        }
        
        switchesStack.pinLeft(to: slidersStack.leadingAnchor, Constants.switchesStackLeft)
        switchesStack.pinBottom(to: slidersStack.topAnchor)
    }
    
    // MARK: - Configure add wish button
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        
        addWishButton.setHeight(Constants.wishButtonHeight)
        addWishButton.pinBottom(to: view, Constants.wishButtonBottom)
        addWishButton.pinHorizontal(to: view, Constants.wishButtonSide)
        
        addWishButton.backgroundColor = Constants.wishButtonBackgroundColor
        addWishButton.setTitleColor(Constants.wishButtonTitleColor, for: .normal)
        addWishButton.setTitle(Constants.wishButtonText, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.wishButtonCornerRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    @objc func addWishButtonPressed() {
        let wishStore = WishStoringViewController()
        wishStore.modalPresentationStyle = .pageSheet
        wishStore.isModalInPresentation = false
        present(wishStore, animated: true, completion: nil)
        
    }
    
    // MARK: - Configure button random color
    private func configureButtonRandomColor() {
        randomColorButton.setTitle(Constants.randomColorButtonText, for: .normal)
        randomColorButton.backgroundColor = .blue
        randomColorButton.setTitleColor(.white, for: .normal)
        randomColorButton.layer.cornerRadius = Constants.randomColorButtonCornerRadius
        randomColorButton.addTarget(self, action: #selector(randomColorButtonTapped), for: .touchUpInside)
        
        view.addSubview(randomColorButton)
        
        randomColorButton.pinLeft(to: switchesStack.trailingAnchor, Constants.randomColorButtonLeft)
        randomColorButton.pinBottom(to: switchesStack, Constants.randomColorButtonBottom)
        randomColorButton.setWidth(Constants.randomColorButtonWidth)
    }
    
    @objc func randomColorButtonTapped() {
        view.backgroundColor = UIColor(UIColor.generateRandomHexColor())
        backgroundColorChanged?()
    }
    
    // MARK: - Configure color picker button
    private func configureColorPickerButton() {
        colorPickerButton.setTitle(Constants.colorPickerText, for: .normal)
        colorPickerButton.backgroundColor = .blue
        colorPickerButton.setTitleColor(.white, for: .normal)
        colorPickerButton.layer.cornerRadius = Constants.colorPickerCornerRadius
        colorPickerButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        
        view.addSubview(colorPickerButton)
        
        colorPickerButton.setWidth(Constants.colorPickerCornerWidth)
        colorPickerButton.pinBottom(to: switchesStack, Constants.colorPickerCornerBottom)
        colorPickerButton.pinLeft(to: randomColorButton.trailingAnchor, Constants.colorPickerCornerLeft)
        
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        view.backgroundColor = viewController.selectedColor
        backgroundColorChanged?()
        viewController.dismiss(animated: true)
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        view.backgroundColor = viewController.selectedColor
        backgroundColorChanged?()
    }
    
    private func presentColorPicker() {
        if #available(iOS 14.0, *) {
            let colorPicker = UIColorPickerViewController()
            colorPicker.delegate = self
            present(colorPicker, animated: true)
            return
        }
        randomColorButtonTapped()
    }
    
    @objc private func colorButtonTapped() {
        presentColorPicker()
    }
}
