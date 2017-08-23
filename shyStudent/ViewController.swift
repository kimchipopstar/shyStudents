//
//  ViewController.swift
//  shyStudent
//
//  Created by Jaewon Kim on 2017-08-19.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var signinSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var signinLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    
    var isSignin:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signinSegmentedControlTapped(_ sender: UISegmentedControl) {
        
        isSignin = !isSignin
        
        if isSignin {
            signinLabel.text = "Sign in"
            signinButton.setTitle("Sign in", for: .normal)
        } else {
            signinLabel.text = "Sing up"
            signinButton.setTitle("Sign up", for: .normal)
        }
        
    }


    @IBAction func signinButtonTapped(_ sender: Any) {
        
        
        if let email = emailTextField.text , let password = passwordTextField.text
        {
            
            if isSignin
            {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    
                    if user != nil
                    {
                        self.performSegue(withIdentifier: "goToMainView", sender: self)
                    }
                        
                    else
                    {
                        //                        check error and show message
                    }
                    
                })
                
            }
            else
            {
                
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    
                    if user != nil
                    {
                        self.performSegue(withIdentifier: "goToMainView", sender: self)
                    }
                        
                    else
                    {
                        
                    }
                })
            }
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    

}

