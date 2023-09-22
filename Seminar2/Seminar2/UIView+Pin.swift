//
//  UIView+Pin.swift
//  Seminar2
//
//  Created by Aubkhon Abdullaev on 22.09.2023.
//

import UIKit

extension UIView {
    enum ConstraintMode {
        case equal // ==
        case grOE // greater or equal >=
        case lsOE // less or equal <=
    }
    
    // MARK: - Pin left
    @discardableResult
    func pinLeft(
        to otherView: UIView,
        const: Double = 0,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, leadingAnchor, otherView.leadingAnchor, constant: const)
    }
    
    @discardableResult
    func pinLeft(
        to anchor: NSLayoutXAxisAnchor,
        const: Double = 0,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, leadingAnchor, anchor, constant: const)
    }
    
    // MARK: - Pin right
    @discardableResult
    func pinRight(
        to otherView: UIView,
        const: Double = 0,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, trailingAnchor, otherView.trailingAnchor, constant: -1 * const)
    }
    
    @discardableResult
    func pinRight(
        to anchor: NSLayoutXAxisAnchor,
        const: Double = 0,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, trailingAnchor, anchor, constant: -1 * const)
    }
    
    // MARK: - Pin top
    @discardableResult
    func pinTop(
        to otherView: UIView,
        const: Double = 0,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, topAnchor, otherView.topAnchor, constant: const)
    }
    
    @discardableResult
    func pinTop(
        to anchor: NSLayoutYAxisAnchor,
        const: Double = 0,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, topAnchor, anchor, constant: const)
    }
    
    // MARK: - Pin bottom
    @discardableResult
    func pinBottom(
        to otherView: UIView,
        const: Double = 0,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, bottomAnchor, otherView.bottomAnchor, constant: -1 * const)
    }
    
    @discardableResult
    func pinBottom(
        to anchor: NSLayoutYAxisAnchor,
        const: Double = 0,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, bottomAnchor, anchor, constant: -1 * const)
    }
    
    // MARK: - Pin center
    @discardableResult
    func pinCentre(
        to otherView: UIView,
        const: Double = 0,
        mode: ConstraintMode = .equal) -> NSLayoutConstraint {
            pinCentreX(to: otherView, const: const, mode: mode)
            return pinCentreY(to: otherView, const: const, mode: mode)
        }
    
    @discardableResult
    func pinCentreX(
        to otherView: UIView,
        const: Double = 0,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, centerXAnchor, otherView.centerXAnchor, constant: const)
    }
    
    @discardableResult
    func pinCentreY(
        to otherView: UIView,
        const: Double = 0,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, centerYAnchor, otherView.centerYAnchor, constant: const)
    }
    
    // MARK: - Pin width
    @discardableResult
    func pinWidth(
        to otherView: UIView,
        mult: Double = 1,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, widthAnchor, otherView.widthAnchor, multipier: mult)
    }
    
    // MARK: - Pin height
    @discardableResult
    func pinHeight(
        to otherView: UIView,
        mult: Double = 1,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, heightAnchor, otherView.heightAnchor, multipier: mult)
    }
    
    // MARK: - Set width
    @discardableResult
    func setWidth(
        const: Double = 1,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinDimension(mode: mode, widthAnchor, constant: const)
    }
    
    // MARK: - Set height
    @discardableResult
    func setHeight(
        const: Double = 1,
        mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinDimension(mode: mode, heightAnchor, constant: const)
    }
    
    // MARK: - Private methods
    @discardableResult
    private func pinConstraint<Axis: AnyObject, AnyAnchor: NSLayoutAnchor<Axis>> (
        mode : ConstraintMode,
        _ firstConstraint: AnyAnchor,
        _ secondConstraint: AnyAnchor,
        constant: Double = 0
    ) -> NSLayoutConstraint {
        let const = CGFloat(constant)
        let result: NSLayoutConstraint
        
        translatesAutoresizingMaskIntoConstraints = false
        
        switch mode {
        case .equal:
            result = firstConstraint.constraint(equalTo: secondConstraint, constant: const)
        case .grOE:
            result = firstConstraint.constraint(greaterThanOrEqualTo: secondConstraint, constant: const)
        case .lsOE:
            result = firstConstraint.constraint(lessThanOrEqualTo: secondConstraint, constant: const)
        }
        
        result.isActive = true
        return result
    }
    
    @discardableResult
    private func pinConstraint(
        mode : ConstraintMode,
        _ firstConstraint: NSLayoutDimension,
        _ secondConstraint: NSLayoutDimension,
        multipier: Double = 1
    ) -> NSLayoutConstraint {
        let mult = CGFloat(multipier)
        let result: NSLayoutConstraint
        
        translatesAutoresizingMaskIntoConstraints = false
        
        switch mode {
        case .equal:
            result = firstConstraint.constraint(equalTo: secondConstraint, multiplier: mult)
        case .grOE:
            result = firstConstraint.constraint(greaterThanOrEqualTo: secondConstraint, multiplier: mult)
        case .lsOE:
            result = firstConstraint.constraint(lessThanOrEqualTo: secondConstraint, multiplier: mult)
        }
        
        result.isActive = true
        return result
    }
    
    @discardableResult
    private func pinDimension(
        mode : ConstraintMode,
        _ dimension: NSLayoutDimension,
        constant: Double = 0
    ) -> NSLayoutConstraint {
        let const = CGFloat(constant)
        let result: NSLayoutConstraint
        
        translatesAutoresizingMaskIntoConstraints = false
        
        switch mode {
        case .equal:
            result = dimension.constraint(equalToConstant: const)
        case .grOE:
            result = dimension.constraint(greaterThanOrEqualToConstant: const)
        case .lsOE:
            result = dimension.constraint(lessThanOrEqualToConstant: const)
        }
        
        result.isActive = true
        return result
    }
    
}
