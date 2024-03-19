//
//  ViewController.swift
//  TestsSeminar
//
//  Created by Aubkhon Abdullaev on 01.03.2024.
//

import UIKit

class UserViewController: UIViewController {
    public var provider: Provider = LegendProvider()
    
    var imageView: UIImageView = UIImageView()
    var nameLabel: UILabel = UILabel()
    
    var userManager: UserManager = UserManager(user: User(name: "", lastname: "", age: 1, link: "https://chat.openai.com/c/7ceff1c2-2789-42c1-9a80-1e168aa07f92"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager = UserManager(user: provider.user())
        configureUI()
        userManager.downloadUserImage { [weak self] image in
            DispatchQueue.main.async {
                if let image = image {
                    self?.imageView.image = image
                    self?.updateUserInfo()
                }
            }
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        view.addSubview(nameLabel)
        
        imageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        imageView.pinRight(to: view)
        imageView.pinLeft(to: view)
        imageView.setWidth(100)
        imageView.setHeight(100)
        
        nameLabel.pinTop(to: imageView.bottomAnchor)
        nameLabel.pinCenterX(to: view)
        nameLabel.text = "Имя: \(provider.user().name)\nФамилия: \(provider.user().lastname)\nВозраст: \(provider.user().age)"
        
    }
    
    private func updateUserInfo() {
        nameLabel.text = "Имя: \(provider.user().name)\nФамилия: \(provider.user().lastname)\nВозраст: \(provider.user().age)"
    }
}

