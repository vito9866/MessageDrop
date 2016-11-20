//
//  TopMenuBar.swift
//  MessengerAppIPhone
//
//  Created by victor on 30/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class TopMenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "CellId"
    
    var widthConstraint: CGFloat = 0.0
    
    let tabNames = ["Chats", "Search", "Profile" ]
    
    var mainViewController: MainViewController?
    
    var selectedBarLeftAnchor: NSLayoutConstraint?
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let tabBarWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 234.0/255.0, green: 77.0/255.0, blue: 138.0/255.0, alpha: 1.0/1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tabBarWrapper)
        tabBarWrapper.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tabBarWrapper.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tabBarWrapper.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tabBarWrapper.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        widthConstraint = UIScreen.main.bounds.width / 3 - 20
        setupSelectedBar()
        
        collectionView.register(TopMenuBarCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.backgroundColor = UIColor.clear
        
        
        let selectedItem = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedItem as IndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
        selectedBarLeftAnchor?.constant = 0 * UIScreen.main.bounds.width / 3 + 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TopMenuBarCell
        cell.tabTitleLabel.text = tabNames[indexPath.row]
        cell.tintColor = UIColor(red: 187.0/255.0, green: 192.0/255.0, blue: 200.0/255.0, alpha: 1.0/1.0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainViewController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func setupSelectedBar() {
        let barView = UIView()
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.backgroundColor = UIColor(red: 208.0/255.0, green: 38.0/255.0, blue: 104.0/255.0, alpha: 1.0/1.0)
        barView.layer.cornerRadius = 14.0
        barView.clipsToBounds = true
        
        addSubview(barView)
        barView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        barView.widthAnchor.constraint(equalToConstant: widthConstraint).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        selectedBarLeftAnchor = barView.leftAnchor.constraint(equalTo: leftAnchor)
        selectedBarLeftAnchor?.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
