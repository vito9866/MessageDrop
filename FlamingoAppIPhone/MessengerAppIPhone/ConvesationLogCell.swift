//
//  ConvesationLogCell.swift
//  MessengerAppIPhone
//
//  Created by victor on 24/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class ConversationLogCell: UICollectionViewCell {
    
    let textViewMessage: UITextView = {
        let textView = UITextView()
        //textView.text = "SAMPLE TEXT FOR ROW"
        //textView.font = UIFont(name: "system", size: 16)
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    let textViewTime: UITextView = {
        let timeView = UITextView()
        //timeView.text = "00:00"
        //textView.font = UIFont(name: "system", size: 16)
        timeView.font = UIFont.systemFont(ofSize: 12, weight: 0.3)
        timeView.textColor = UIColor(red: 187.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 1.0/1.0)
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.backgroundColor = UIColor.clear
        timeView.scrollsToTop = true
        return timeView
    }()
    
    /*let textViewTime: UITextView = {
        let timeView = UITextView()
        timeView.text = "00:00"
        timeView.font = UIFont.systemFont(ofSize: 13, weight: 1)
        //timeView.textColor = UIColor(red: 187.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 1.0/1.0)
        timeView.textColor = UIColor.red
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.backgroundColor = UIColor.clear
        return timeView
    }()*/
    
    var wrapperView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        //view.layer.roundCorners(corners: [.topLeft, .bottomLeft, .bottomRight], radius: 15)
        //view.backgroundColor = UIColor(red: 75.0/255.0, green: 93.0/255.0, blue: 149.0/255.0, alpha: 1.0/1.0)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /*let gradientLayer: CAGradientLayer = {
        let grLayer = CAGradientLayer()
        grLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 1000)
        grLayer.colors = [UIColor(red: 178.0/255.0, green: 194.0/255.0, blue: 210.0/255.0, alpha: 1.0/1.0).cgColor, UIColor(red: 223.0/255.0, green: 233.0/255.0, blue: 242.0/255.0, alpha: 1.0/1.0).cgColor]
        grLayer.cornerRadius = 15.0
        return grLayer
    }()*/
    
    
    var wrapperWidthAnchor: NSLayoutConstraint?
    var wrapperRightAnchor: NSLayoutConstraint?
    var wrapperLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(wrapperView)
        wrapperRightAnchor = wrapperView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        wrapperRightAnchor?.isActive = true
        wrapperLeftAnchor = wrapperView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        wrapperLeftAnchor?.isActive = false
        wrapperView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        wrapperWidthAnchor = wrapperView.widthAnchor.constraint(equalToConstant: 200)
        wrapperWidthAnchor?.isActive = true
        wrapperView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
       // self.wrapperView.layer.addSublayer(gradientLayer)
        
        addSubview(textViewMessage)
        textViewMessage.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 8).isActive = true
        textViewMessage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textViewMessage.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -10).isActive = true
        textViewMessage.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        addSubview(textViewTime)
        
        
        textViewTime.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 10).isActive = true
        textViewTime.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -5).isActive = true
        textViewTime.rightAnchor.constraint(equalTo: wrapperView.rightAnchor).isActive = true
        //textViewTime.widthAnchor.constraint(equalToConstant: 50).isActive = true
        textViewTime.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        /*textViewTime.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 8).isActive = true
        textViewTime.topAnchor.constraint(equalTo: textViewMessage.bottomAnchor, constant: 8).isActive = true
        textViewMessage.heightAnchor.constraint(equalToConstant: 20).isActive = true*/
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) error")
    }

}
