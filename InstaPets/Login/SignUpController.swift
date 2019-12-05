//
//  ViewController.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 10/31/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import FirebaseCore



class SignUpController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.

        //subview has to be added first or it will crash
        //adding it to the view
//        view.addSubview(label)
        view.addSubview(AddPhotoButton)

        //constraint for the button, textfield
//         labelLayOut()
        addingButtonLayout()


//        view.addSubview(label)

        setupInputField()
        delegateTextField()
        haveAnAccountButton()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }


//MARK: TitleLabel

    let label: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "C0 / Lab"
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel

    }()




//MARK: EmailTextField
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Email"
        textField.text = "moo@aol.com"
        textField.backgroundColor = .init(white: 0, alpha: 0.035)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
//        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    //MARK: Button change color if sign up is filled
    @objc func handleTextInput() {

        let formValid = emailTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0 && userNameTextField.text?.count ?? 0 > 0
        if formValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 250)
        }
    }

//MARK: UserName TextField

    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "meowFuzzy"
        textField.placeholder = " Username"
        textField.backgroundColor = .init(white: 0, alpha: 0.035)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
//        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()


//MARK: Password Text Field
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.text = "123456"
        textField.backgroundColor = .init(white: 0, alpha: 0.035)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
//        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

//MARK: signUpButton
    let signUpButton: UIButton = {
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
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button

    }()

    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        userNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true;
    }

    func delegateTextField(){
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self

     }

    @objc func keyboardWillChange(notification: NSNotification) {
        print("keyboard will show: \(notification.name.rawValue)")
        guard let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillHideNotification {
            view.frame.origin.y = -keyboardHeight.height
        } else {
            view.frame.origin.y = 0
        }

    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }




     @objc func handleSignUp() {
        print("Sign Up button")

        /*to check the empty strings*/
        guard let email = emailTextField.text  else {

            print("error")
            return}

        guard let username = userNameTextField.text else {
            print("error")
            return
        }
        guard let password = passwordTextField.text else {
            print("error")
            return }

        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in

            if let error = error {
                print ("error", error)
                return
            }

            guard let uid = user?.user.uid else {return}
            guard let image = self.AddPhotoButton.imageView?.image else {return}
            let uploadData = image.jpegData(compressionQuality: 0.3)
            let filename = NSUUID().uuidString
            let imageFolder = Storage.storage().reference().child("profile_image").child(filename)

            imageFolder.putData(uploadData!, metadata: nil) { (metadata, error) in
                if error != nil{
                    print(error!.localizedDescription)
                }
                imageFolder.downloadURL { (url, error) in
                    guard let urldownload = url?.absoluteString else {return}
                    print(urldownload)


                    let dictionaryValue = ["username": username, "profileImageURL": urldownload ]
                    let values = [uid:dictionaryValue]

                    Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                        if let error = err {
                            print("failed to save to database", error)
                        }

                        print("succesfully saved in the database")

                    }
                }
            }

//            //                using database but this set up a single value
//            Database.database().reference().child("users").setValue(values) { (err, ref) in
//                if let error = err {
//                    print("failed to save to database", error)
//                }
//
//                print("succesfully saved in the database")
//            }
//


            print(user!.user.uid)

        })





    }
    //MARK: addPhotoButton

    let AddPhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        //adding image to the button with rederingMode, you chage to original image in the image assets as well
        button.setImage(UIImage.init(named: "plus_photo")!.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        return button
    }()



    @objc func addPhoto() {
        print("testing button")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        guard let originalImage = info[(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {return}
        AddPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)

        guard let editImage = info[(UIImagePickerController.InfoKey.editedImage)] as? UIImage else {return}
        AddPhotoButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
        /*getting detail of the image*/
        print(originalImage.size, editImage.size)

        AddPhotoButton.layer.cornerRadius = AddPhotoButton.frame.width/2
        AddPhotoButton.layer.masksToBounds = true
        AddPhotoButton.layer.borderColor = UIColor.black.cgColor
        AddPhotoButton.layer.borderWidth = 3


        dismiss(animated: true, completion: nil)
    }

    func addingButtonLayout(){
        //customizing the button
        AddPhotoButton.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
//        //centering your button in the view
        AddPhotoButton.center = view.center
//        //adding constraint to the button
        AddPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        //40 pixel to the top of the view, but its is 200 becuase i want it to be in the center

        AddPhotoButton.anchor(top: view.topAnchor, left: nil, right: nil, bottom: nil, paddlingTop: 100, paddlingLeft: 0, paddlngBottom: 0, paddlingRight: 0, width: 140, height: 140)
    }

    func labelLayOut() {

        label.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
        label.center = view.center
        label.anchor(top: view.topAnchor, left: view.leadingAnchor, right: view.rightAnchor, bottom: nil, paddlingTop: 30, paddlingLeft: 20, paddlngBottom: 0, paddlingRight: 20, width: 0, height: 30)

    }

    func haveAnAccountButton(){

        let signUpButton : UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Back to Login", for: .normal)
            button.addTarget(self, action: #selector(handlebackButton), for: .touchUpInside)
            return button
        }()
        self.view.addSubview(signUpButton)

        signUpButton.anchor(top: nil, left: self.view.leftAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, paddlingTop: 0, paddlingLeft: 0, paddlngBottom: -10, paddlingRight: 0, width: 0, height: 50)

    }
    @objc func handlebackButton() {

           navigationController?.popViewController(animated: true)
       }


    //before adding stackview

/*   func emailTextFieldLayout(){
        emailTextField.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
            emailTextField.topAnchor.constraint(equalTo:AddPhotoButton.bottomAnchor, constant: 40).isActive = true
       emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    emailTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

  }


    //disable the autorotation of the device
*/
override open var shouldAutorotate: Bool {
        return false
    }


    fileprivate func setupInputField() {

        //adding the view into stackview
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signUpButton])


        //stackview properties
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)

        //using the extension at most here
        stackView.anchor(top: AddPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddlingTop: 40, paddlingLeft: 30, paddlngBottom: 0, paddlingRight: 30, width: 0, height: 200)


        /* by using the extension you can reuse the anchor at at more convient way */


        //constraint for the stack view
//                stackView.topAnchor.constraint(equalTo:AddPhotoButton.bottomAnchor, constant: 40).isActive = true
//                stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
//                stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
//                stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true


    }






}



