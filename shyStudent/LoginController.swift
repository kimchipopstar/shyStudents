//
//  LoginController.swift
//  MidtermProj2018
//
//  Created by Mohammad Shahzaib Ather on 2017-08-21.
//  Copyright © 2017 Mohammad Shahzaib Ather. All rights reserved.
//


import UIKit
import Firebase



//protocol isStudentTeacher{
//    
//    func updateStudentTeacherSegmentedController(_ : int ) -> (Bool)()
//    
//}



class LoginController: UIViewController , UITextFieldDelegate{
    
    
    var isStudent : Bool = false
    
    var colorGenerator = ColorGenerator()
    
    let inputsContainerView : UIView  = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterButton : UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = UIColor.gray
        button.setTitle("Register", for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    func handleLoginRegister() {
        if loginOrRegisterSegmentedControl.selectedSegmentIndex == 1 {
            handleRegister()
        }
        if loginOrRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        }
        else {
        print("Form is invalid")
            }
}
    func handleLogin() {
        guard let email = emailTextField.text , let password = passwordTextField.text
            else {
                print("form is not valid")
                return
    }
        Auth.auth().signIn(withEmail: email, password: password) { (user: User?,  error) in
            
            if  error != nil {
               print(error!)
                return
            }
//            self.dismiss(animated: true, completion: nil)
            
            
            // MARK: - Create Channel View Controller (ChatViewController)
            let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            guard let channelVC = sb.instantiateInitialViewController() as? ChatViewController else {
                return //do some kind of error
            }
            // not too sure if we want name or email here
            channelVC.senderDisplayName = email
            channelVC.isStudent = self.isStudent
            self.navigationController?.show(channelVC, sender: self)
        }
    }
    
    
    let askLabel : UILabel = {
        let label = UILabel()
        label.text = "ASK"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let awayLabel : UILabel = {
        let label = UILabel()
        label.text = "AWAY"
        label.textColor = UIColor.white
        label.font = label.font.withSize(70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    
    
    func handleRegister() {
        guard let email = emailTextField.text , let password = passwordTextField.text , let name = nameTextField.text
            else {
                print("form is not valid")
                return
                        }
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error) in
            if error != nil{
                return
            }
        
    //Successfully authenticated user 
            
            let ref = Database.database().reference()
            let values = ["name": name, "email" :email]
            ref.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if error != nil{
                    return
                }
                print("Saved user successfully into Firebase database")
            })
            
            
            
        }
        
    }
    
  
    
    
    let nameTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.masksToBounds = true
        return tf
    } ()
    
    let emailTextField : UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.layer.masksToBounds = true
        return emailTextField
    } ()
    
    let passwordTextField : UITextField = {
        let passwordtf = UITextField()
        passwordtf.placeholder = "Password"
        passwordtf.translatesAutoresizingMaskIntoConstraints = false
        passwordtf.isSecureTextEntry = true
        passwordtf.layer.masksToBounds = true
        return passwordtf
    } ()
    
    
    lazy var  loginOrRegisterSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Login" , "Register"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()
    
    
    lazy var  studentTeacherSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Student" , "Teacher"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(handleStudentTeacher), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()
    
  open func handleStudentTeacher() {
        if studentTeacherSegmentedControl.selectedSegmentIndex == 0 {
         //write code for deleting or hiding the create "classes" bar 
            isStudent = true
        }
        if studentTeacherSegmentedControl.selectedSegmentIndex == 1 {
          //do nothing
            isStudent = false
        }
        else {
            print("Form is invalid")
        }
    }
    
    
    
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customColor: UIColor = UIColor(r:66, g: 244, b: 188)
        let colorGen = ColorGenerator()
        colorGen.colorsArray.add(customColor)
        view.backgroundColor = colorGen.randomColor();
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginOrRegisterSegmentedControl)
        view.addSubview(studentTeacherSegmentedControl)
        view.addSubview(askLabel)
        view.addSubview(awayLabel)
        
        
        setupLabelsConstraints()
        setupInputsContainerView()
        setupRegisterButtonView()
        setupLoginRegisterSegmentedControlConstraints()
        setupStudentTeacherSegmentedControlConstraints()
        handleStudentTeacher()
        
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func handleLoginRegisterChange() {
        
       let title = loginOrRegisterSegmentedControl.titleForSegment(at: loginOrRegisterSegmentedControl.selectedSegmentIndex)

       loginRegisterButton.setTitle(title, for: UIControlState())
       loginRegisterButton.setTitle(title, for: UIControlState.normal)

    //Changing heigh of inputscontainer if we change to login
    inputsContainerViewHeightAnchor?.constant = loginOrRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
    //Changing nameTextfield
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier:  loginOrRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier:  loginOrRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        
        passTextFieldHeightAnchor?.isActive = false
        passTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier:  loginOrRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passTextFieldHeightAnchor?.isActive = true
        
    }
    
    
    func setupLoginRegisterSegmentedControlConstraints (){
        loginOrRegisterSegmentedControl.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        loginOrRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginOrRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginOrRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 20).isActive = true

    }
    
    func setupStudentTeacherSegmentedControlConstraints() {
        studentTeacherSegmentedControl.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        studentTeacherSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        studentTeacherSegmentedControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        studentTeacherSegmentedControl.bottomAnchor.constraint(equalTo: loginOrRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        
        
        
    }
    
    
    var inputsContainerViewHeightAnchor : NSLayoutConstraint?
    var nameTextFieldHeightAnchor : NSLayoutConstraint?
    var emailTextFieldHeightAnchor : NSLayoutConstraint?
    var passTextFieldHeightAnchor : NSLayoutConstraint?
    
    
    func setupInputsContainerView() {
        
        //Input textfield
        
        
        
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        //Name textfield
        inputsContainerView.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor ).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //Email textfield
        inputsContainerView.addSubview(emailTextField)
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor ).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
       
        
        
        emailTextFieldHeightAnchor =  emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //Password textfield
        
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor ).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        
        passTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passTextFieldHeightAnchor?.isActive = true
        
        
        
        
    }
    
    func setupLabelsConstraints(){
    askLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    awayLabel.bottomAnchor.constraint(equalTo: studentTeacherSegmentedControl.topAnchor, constant: -20).isActive = true
    awayLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    askLabel.bottomAnchor.constraint(equalTo: studentTeacherSegmentedControl.topAnchor, constant: -70).isActive = true
        
        
    }
    
    
    func setupRegisterButtonView () {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.centerYAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 20).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    
    // MARK : textfield delegate methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

extension UIColor {
    convenience init(r :CGFloat ,  g:CGFloat, b: CGFloat) {
        self.init (red: r/255 , green: g/255, blue: b/255, alpha:1 )
    }
}


