//
//  ConvesationLogCell.swift
//  MessengerAppIPhone
//
//  Created by victor on 24/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class ConversationLogCell: UICollectionViewCell {
    
    var conversationLogCollectionViewController: ConversationLogCollectionViewController?
    
    let textViewMessage: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    lazy var imageViewMessage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        //imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openImageFullScreen)))
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.font = UIFont.systemFont(ofSize: 12, weight: 0.2)
        tLabel.textColor = UIColor(red: 187.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 1.0/1.0)
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        tLabel.backgroundColor = UIColor.clear
        return tLabel
    }()
    
    var wrapperView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        
        addSubview(textViewMessage)
        textViewMessage.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 8).isActive = true
        textViewMessage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textViewMessage.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -10).isActive = true
        textViewMessage.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textViewMessage.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        
        addSubview(imageViewMessage)
        imageViewMessage.leftAnchor.constraint(equalTo: wrapperView.leftAnchor).isActive = true
        imageViewMessage.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
        imageViewMessage.widthAnchor.constraint(equalTo: wrapperView.widthAnchor).isActive = true
        imageViewMessage.heightAnchor.constraint(equalTo: wrapperView.heightAnchor).isActive = true
        
        addSubview(timeLabel)
        timeLabel.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 12).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -7).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: wrapperView.rightAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) error")
    }
    
    func openImageFullScreen(tapGesture: UITapGestureRecognizer) {
        print("Open Photo")
        if let imageView = tapGesture.view as? UIImageView {
            self.conversationLogCollectionViewController?.performFullScreenForImageView(imageView: imageView)
        }
    }
    
}
