//
//  MyCell.swift
//  collectionViewTest
//
//  Created by Aubkhon Abdullaev on 20.10.2023.
//

import UIKit

class MyCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let myTextLabel1 : UILabel = {
        let control = UILabel()
        control.textColor = .red
        control.text = "test1"
        return control
    }()
    
    let myTextLabel2 : UILabel = {
        let control = UILabel()
        control.textColor = .red
        control.text = "test2"
        return control
    }()
    
    private func addView() {
        backgroundColor = UIColor.black;
        addSubview(myTextLabel1)
        addSubview(myTextLabel2)
        myTextLabel1.pinLeft(to: self, frame.width / 2 - 34)
        myTextLabel1.pinTop(to: self, 5)
        myTextLabel1.setHeight(20)
        myTextLabel1.setWidth(100)
        //        myTextLabel1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width / 2 - 30).isActive = true
        //        myTextLabel1.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        //        myTextLabel1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //        myTextLabel1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        myTextLabel2.pinLeft(to: self, 5)
        myTextLabel2.pinTop(to: myTextLabel1.bottomAnchor, 5)
        myTextLabel2.setHeight(20)
        myTextLabel2.setWidth(100)
        //        myTextLabel2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        //        myTextLabel2.topAnchor.constraint(equalTo: myTextLabel1.bottomAnchor, constant: 10).isActive = true
        //        myTextLabel2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //        myTextLabel2.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
}
