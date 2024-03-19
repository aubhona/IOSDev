//
//  BrandCollectionView.swift
//  Practice8
//
//  Created by Aubkhon Abdullaev on 19.03.2024.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.layer.cornerRadius = min(frame.width, frame.height) / 2.0
        contentView.backgroundColor = UIColor("f2f2f7")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with imagePath: String) {
        imageView.image = UIImage(named: imagePath)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
}
