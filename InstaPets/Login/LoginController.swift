//
//  LoginController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/3/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit
import Pastel


class LoginController: UIViewController, UITextFieldDelegate {



    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        containerViewLayOut()
        setupInputField()
        signUpButtonConf()
        delegateTextField()
        gradientEffect()



    }

    //MARK: UserName TextField

    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "meowFuzzy"
        textField.placeholder = " Username"
        textField.backgroundColor = .init(white: 0, alpha: 0.135)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)

        //            textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        //        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()


    //MARK: Password Text Field
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.text = "123456"
        textField.backgroundColor = .init(white: 0, alpha: 0.135)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        //            textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        //        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    //MARK: login button
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        /*       button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1) */
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 250)




        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        //setup the edges of the buttons
        button.layer.cornerRadius = 5
        //disable the button action
        button.isEnabled = false
        //add action for the button
        //            button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button

    }()


    func gradientEffect(){
        let pastelView = PastelView(frame: view.bounds)
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        pastelView.animationDuration = 3.0
        pastelView.setColors([
            //                                    UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
            //                                     UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
            //                                     UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
            UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
            UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
            UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
            UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])

        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }


    func delegateTextField(){
        userNameTextField.delegate = self
        passwordTextField.delegate = self

    }

    func containerViewLayOut(){
        let containerView: UIView = {
            let view = UIView()
            let labelview = UILabel()
            labelview.backgroundColor = .clear
            labelview.text = "InstaPets"
            labelview.textColor = .white
            labelview.enableTogglingFontsOnTap()
            labelview.font = UIFont(name: "Didot-Bold", size: 40)
            labelview.textAlignment = .center

            view.addSubview(labelview)
            labelview.anchor(top: nil, left: nil, right: nil, bottom: nil, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 50)
            labelview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            labelview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

            view.backgroundColor = UIColor.clear
            return view

        }()
        self.view.addSubview(containerView)
        containerView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, bottom: nil, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 0, height: 150)
    }




    func signUpButtonConf(){

        let signUpButton : UIButton = {
            let button = UIButton(type: .system)
            let attributezTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 14)!, NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            attributezTitle.append(NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14)!, NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 17, green: 154, blue: 237)]))
            button.setAttributedTitle(attributezTitle, for: .normal)
//            button.setTitle("Don't have an account, Sign Up", for: .normal)
            button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
            return button
        }()
        self.view.addSubview(signUpButton)

        signUpButton.anchor(top: nil, left: self.view.leftAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: -10, paddlingRight: 0, width: 0, height: 50)

    }


    @objc func handleShowSignUp() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    fileprivate func setupInputField() {

        //adding the view into stackview
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, passwordTextField, logInButton])


        //stackview properties
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)

        //using the extension at most here
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddlingTop: 200 , paddlingLeft: 30, paddlngBottom: 0, paddlingRight: 30, width: 0, height: 200)


        /* by using the extension you can reuse the anchor at at more convient way */


        //constraint for the stack view
        //                stackView.topAnchor.constraint(equalTo:AddPhotoButton.bottomAnchor, constant: 40).isActive = true
        //                stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        //                stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        //                stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true


    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true;
    }




}
