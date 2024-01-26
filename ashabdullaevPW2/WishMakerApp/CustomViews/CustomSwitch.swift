//
//  CustomSwitch.swift
//  ashabdullaevPW2
//
//  Created by Aubkhon Abdullaev on 06.10.2023.
//

import UIKit

final class CustomSwitch: UIView {
    enum Constants {
        static let titleLabelCentreX = 10.0
        static let titleLabelTop = 10.0
        static let titleLabelLeft = 20.0
        
        static let innerSwitchTop = 5.0
        static let innerSwitchCentreX = 10.0
        static let innerSwitchBottom = 10.0
        static let innerSwitcLeft = 20.0
    }
    
    var tapped: (() -> Void)?
    
    var innerSwitch = UISwitch()
    var titleLabel = UILabel()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        innerSwitch.addTarget(self, action: #selector(sliderValueChanged), for: .touchUpInside)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        for view in [innerSwitch, titleLabel] {
            addSubview(view)
        }
        
        titleLabel.pinCenterX(to: centerXAnchor, Constants.titleLabelCentreX)
        titleLabel.pinTop(to: topAnchor, Constants.titleLabelTop)
        titleLabel.pinLeft(to: leadingAnchor, Constants.titleLabelLeft)
        titleLabel.pinWidth(to: widthAnchor)
        
        innerSwitch.pinTop(to: titleLabel.bottomAnchor, Constants.innerSwitchTop)
        innerSwitch.pinCenterX(to: centerXAnchor, Constants.innerSwitchCentreX)
        innerSwitch.pinBottom(to: bottomAnchor, Constants.innerSwitchBottom)
        innerSwitch.pinLeft(to: leadingAnchor, Constants.innerSwitcLeft)
    }
    
    @objc
    private func sliderValueChanged() {
        tapped?()
    }
}
