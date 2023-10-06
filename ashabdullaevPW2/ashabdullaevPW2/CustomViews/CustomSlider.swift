//
//  CustomSlider.swift
//  ashabdullaevPW2
//
//  Created by Aubkhon Abdullaev on 03.10.2023.
//

import UIKit

final class CustomSlider: UIView {
    enum Constants {
        static let titleLabelTop = 10.0
        static let titleLabelLeft = 20.0
        
        static let sliderBottom = 10.0
        static let sliderLeft = 20.0
    }
    
    var valueChanged: (() -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        for view in [slider, titleView] {
            addSubview(view)
        }
        
        titleView.pinCenterX(to: centerXAnchor)
        titleView.pinTop(to: topAnchor, Constants.titleLabelTop)
        titleView.pinLeft(to: leadingAnchor, Constants.titleLabelLeft)
        
        slider.pinTop(to: titleView.bottomAnchor)
        slider.pinCenterX(to: centerXAnchor)
        slider.pinBottom(to: bottomAnchor, Constants.sliderBottom)
        slider.pinLeft(to: leadingAnchor, Constants.sliderLeft)
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?()
    }
}
