//
//  File.swift
//  MessengerAppIPhone
//
//  Created by victor on 30/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class TopMenuBarCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    let tabTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chats"
        label.textColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 224.0/255.0, alpha: 1.0/1.0)
        label.font = UIFont.systemFont(ofSize: 14, weight: 0.2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    func setupViews() {
        addSubview(tabTitleLabel)
        tabTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tabTitleLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        tabTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tabTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override var isHighlighted: Bool {
        didSet {
            tabTitleLabel.textColor = isHighlighted ? UIColor.white : UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 224.0/255.0, alpha: 1.0/1.0)
            tabTitleLabel.font = isHighlighted ? UIFont.systemFont(ofSize: 14, weight: 0.3) : UIFont.systemFont(ofSize: 14, weight: 0.1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            tabTitleLabel.textColor = isSelected ? UIColor.white : UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 224.0/255.0, alpha: 1.0/1.0)
            tabTitleLabel.font = isSelected ? UIFont.systemFont(ofSize: 14, weight: 0.3) : UIFont.systemFont(ofSize: 14, weight: 0.1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
