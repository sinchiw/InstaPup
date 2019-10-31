//
//  ViewController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 10/31/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //subview has to be added first or it will crash
        //adding it to the view
        view.addSubview(AddPhotoButton)

        //constraint for the button, textfield
        addingButtonLayout()
//        emailTextFieldLayout()
        setupInputField()
    }





    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Email"
        textField.backgroundColor = .init(white: 0, alpha: 0.035)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()



    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Username"
        textField.backgroundColor = .init(white: 0, alpha: 0.035)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()



    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .init(white: 0, alpha: 0.035)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()


    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        //setup the edges of the buttons
        button.layer.cornerRadius = 5
        return button

    }()

    let AddPhotoButton: UIButton = {
              let button = UIButton()
              button.backgroundColor = .clear
              //adding image to the button with rederingMode, you chage to original image in the image assets as well
        button.setImage(UIImage.init(named: "plus_photo")!.withRenderingMode(.alwaysOriginal), for: .normal)
              button.translatesAutoresizingMaskIntoConstraints = false
              return button
          }()

    func addingButtonLayout(){
        //customizing the button
        AddPhotoButton.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        //centering your button in the view
        AddPhotoButton.center = view.center
        //adding constraint to the button
        AddPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        AddPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        AddPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //40 pixel to the top of the view
        AddPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    }
    //before adding stackview

//    func emailTextFieldLayout(){
//////        emailTextField.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
////        emailTextField.topAnchor.constraint(equalTo:AddPhotoButton.bottomAnchor, constant: 40).isActive = true
////        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
////        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
////        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
//////      emailTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
////        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//    }
    //disable the autorotation of the device

    override open var shouldAutorotate: Bool {
        return false
    }
    fileprivate func setupInputField() {

        //adding the view into stackview
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signUpButton])

        stackView.translatesAutoresizingMaskIntoConstraints = false

        //stackview properties
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        //constraint for the stack view
                stackView.topAnchor.constraint(equalTo:AddPhotoButton.bottomAnchor, constant: 40).isActive = true
                stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
                stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
                stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true


    }




}

