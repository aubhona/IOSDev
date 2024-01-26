//
//  ViewController.swift
//  ashabdullaevPW1
//
//  Created by Aubkhon Abdullaev on 19.09.2023.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var button: UIButton!
    
    // MARK: View loader
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeCornerRadius()
        changeBackgroundColor(uniqueColors: getUniqueColors())
    }
    
    // MARK: Pressing button handler
    
    @IBAction func buttonWasPressed(_ sender: UIButton) {
        let uniqueColors = getUniqueColors();
        let animationDuration = 3.49
        UIView.animate(withDuration: animationDuration, animations: {
            self.button.isEnabled = false
            self.changeBackgroundColor(uniqueColors: uniqueColors)
            self.changeCornerRadius()
        }, completion: { [weak self] _ in
            self?.button.isEnabled = true
        })
    }
    
    // MARK: Fuction change view's corner radius
    
    func changeCornerRadius() {
        for view in views {
            view.layer.cornerRadius = .random(in: 0...25)
        }
    }
    
    // MARK: Fuction change view's background color
    
    func changeBackgroundColor(uniqueColors: [UIColor]) {
        for i in 0 ..< views.count {
            views[i].backgroundColor = uniqueColors[i]
        }
    }
    
    // MARK: Function generate array of unique UIColor
    
    func getUniqueColors() -> [UIColor] {
        var uniqueColors = [UIColor]()
        for _ in 0 ..< views.count {
            uniqueColors.append(UIColor(hexColor: UIColor.generateRandomHexColor()))
        }
        
        return uniqueColors;
    }
}

// MARK: - UIColor extension

extension UIColor {
    
    // MARK: init convert hex color to RGB
    
    convenience init(hexColor : String) {
        let hexColorChanged = hexColor.replacingOccurrences(of: "#", with: "")
        let base = 16
        let rgb = UInt64(hexColorChanged, radix: base)!
        let maxOfDiapValue = 255.0
        let red = CGFloat((rgb & 0xFF000000) >> 24) / maxOfDiapValue
        let green = CGFloat((rgb & 0x00FF0000) >> 16) / maxOfDiapValue
        let blue = CGFloat((rgb & 0x0000FF00) >> 8) / maxOfDiapValue
        let alpha = CGFloat(rgb & 0x000000FF) / maxOfDiapValue
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // MARK: Random hex color generator
    
    static func generateRandomHexColor() -> String {
        var hexColor = "#"
        let base = 16
        for _ in 0 ..< 3 {
            let randomHex = String(Int.random(in: 0...255), radix: base)
            hexColor += randomHex.count == 1 ? "0" + randomHex : randomHex
        }
        hexColor += String(Int.random(in: 128...255), radix: base)
        return hexColor
    }
}
