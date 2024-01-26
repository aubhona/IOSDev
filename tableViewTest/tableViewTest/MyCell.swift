//
//  MyCellTableViewCell.swift
//  tableViewTest
//
//  Created by Aubkhon Abdullaev on 06.10.2023.
//

import UIKit

class MyCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let myTextLabel1 : UILabel = {
        let control = UILabel()
        control.textColor = .red
        control.text = "test1"
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let myTextLabel2 : UILabel = {
        let control = UILabel()
        control.textColor = .red
        control.text = "test2"
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let dayImageButton : UIButton = {
        var control = UIButton()
        control.backgroundColor = UIColor.white
        control.layer.cornerRadius = 4
        control.clipsToBounds = false
        control.setImage(UIImage(named: "calendar"), for: .normal)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    private func addView() {
        //addSubview(myTextLabel1)
        //addSubview(dayImageButton)
        //dayImageButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        //dayImageButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        //myTextLabel1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        //myTextLabel1.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        //myTextLabel1.heightAnchor.constraint(equalToConstant: 236).isActive = true
        //myTextLabel1.widthAnchor.constraint(equalToConstant: 236).isActive = true
        
    }
    
}
