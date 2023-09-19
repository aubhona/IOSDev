//
//  ViewController.swift
//  ashabdullaevPW1
//
//  Created by Aubkhon Abdullaev on 19.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeCornerRadius()
        changeBackgroundColor(uniqueColors: getUniqueColors())
    }
    
    @IBAction func buttonWasPressed(_ sender: UIButton) {
        let uniqueColors = getUniqueColors();
        UIView.animate(withDuration: 3.49, animations: {
            self.button.isEnabled = false
            self.changeBackgroundColor(uniqueColors: uniqueColors)
            self.changeCornerRadius()
        }, completion: { [weak self] _ in
            self?.button.isEnabled = true
        }
        )
    }
    
    func changeCornerRadius() {
        for view in views {
            view.layer.cornerRadius = .random(in: 0...25)
        }
    }
    
    func changeBackgroundColor(uniqueColors: [UIColor]) {
        for i in 0..<views.count {
            views[i].backgroundColor = uniqueColors[i]
        }
    }
    
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
    
    // MARK: - init convert hex color to RGB
    
    convenience init(hexColor : String) {
        let hexColorChanged = hexColor.replacingOccurrences(of: "#", with: "")
        
        let rgb = UInt64(hexColorChanged, radix: 16)!
        
        let red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
        let green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
        let blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
        let alpha = CGFloat(rgb & 0x000000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // MARK: - Random hex color generator
    
    static func generateRandomHexColor() -> String {
        var hexColor = "#"
        for _ in 0..<3 {
            let randomHex = String(Int.random(in: 0...255), radix: 16)
            hexColor += randomHex.count == 1 ? "0" + randomHex : randomHex
        }
        hexColor += String(Int.random(in: 128...255), radix: 16)
        return hexColor
    }
}
