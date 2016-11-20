//
//  WelcomeViewController.swift
//  MessengerAppIPhone
//
//  Created by victor on 29/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    let bgImageView: UIImageView  = {
        let bgImage = UIImageView()
        bgImage.image = UIImage(named: "WelcomeBG.jpg")
        bgImage.contentMode = .scaleAspectFill
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        bgImage.clipsToBounds = true
        return bgImage
    }()
    
    let logoImageView: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "WelcomeLogo.png")
        logoImage.contentMode = .scaleAspectFill
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        return logoImage
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(named: "SignInButton.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(named: "WelcomeSignUpButton.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        
        let statusBarView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        statusBarView.backgroundColor = UIColor.clear
        view.addSubview(statusBarView)
        
        view.addSubview(bgImageView)
        bgImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let bgView: UIView = {
            let bView = UIView()
            bView.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.9/1.0)
            bView.translatesAutoresizingMaskIntoConstraints = false
            return bView
        }()
        view.addSubview(bgView)
        bgView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let contentView: UIView = {
            let cView = UIView()
            cView.translatesAutoresizingMaskIntoConstraints = false
            return cView
        }()
        view.addSubview(contentView)
        contentView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        contentView.addSubview(logoImageView)
        logoImageView.widthAnchor.constraint(equalToConstant: 118).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 29).isActive = true
        logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(signInButton)
        signInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        signInButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        signInButton.addTarget(self, action: #selector(showSignInController), for: .touchUpInside)
        
        contentView.addSubview(signUpButton)
        signUpButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 142).isActive = true
        signUpButton.addTarget(self, action: #selector(showSignUpController), for: .touchUpInside)
    }
    
    func showSignInController(sender: UIButton) {
        let signInController = SignInViewContoller()
        //signInController.storyboard?.instantiateViewController(withIdentifier: "signInController")
        //let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignInController") as? SignInViewContoller
        let signInNavController = MainNavigationController(rootViewController: signInController)
        //signInNavController.modalTransitionStyle = .partialCurl
        
        //let signInController = self.storyboard?.instantiateViewController(withIdentifier: "SignInController") as? SignInViewContoller
        //self.navigationController?.pushViewController(signInController!, animated: true)
        self.present(signInNavController, animated: true, completion: nil)
    
        let controller = SignInViewContoller(nibName: "SignInViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
        
        //let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("SecondViewController") as SecondViewController
        //self.navigationController.pushViewController(secondViewController, animated: true)
    }
    
    func showSignUpController(sender: UIButton) {
        let signUpController = SignUpViewController()
        let signUpNavController = MainNavigationController(rootViewController: signUpController)
        present(signUpNavController, animated: true, completion: nil)
    }
    
}
