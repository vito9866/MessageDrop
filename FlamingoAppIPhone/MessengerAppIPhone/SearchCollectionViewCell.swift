//
//  SearchCollectionViewCell.swift
//  MessengerAppIPhone
//
//  Created by Victor Macintosh on 16/11/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = UIColor(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1.0/1.0)
        backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let wrapperSearchBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchBar: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(red: 66.0/255.0, green: 76.0/255.0, blue: 92.0/255.0, alpha: 1.0/1.0)
        textField.font = UIFont.systemFont(ofSize: 15, weight: 0.1)
        textField.backgroundColor = UIColor.white
        textField.placeholder = "Search"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SearchIcon.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupViews() {
        
        addSubview(wrapperSearchBar)
        wrapperSearchBar.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        wrapperSearchBar.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        wrapperSearchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        wrapperSearchBar.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        wrapperSearchBar.addSubview(searchIcon)
        searchIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        searchIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        searchIcon.leftAnchor.constraint(equalTo: wrapperSearchBar.leftAnchor, constant: 15).isActive = true
        searchIcon.centerYAnchor.constraint(equalTo: wrapperSearchBar.centerYAnchor).isActive = true
        
        wrapperSearchBar.addSubview(searchBar)
        searchBar.leftAnchor.constraint(equalTo: searchIcon.rightAnchor, constant: 10).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchBar.rightAnchor.constraint(equalTo: wrapperSearchBar.rightAnchor, constant: -15).isActive = true
        searchBar.centerYAnchor.constraint(equalTo: wrapperSearchBar.centerYAnchor).isActive = true
        
    }

}
