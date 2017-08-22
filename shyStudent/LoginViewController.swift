//
//  LoginViewController.swift
//  
//
//  Created by Jaewon Kim on 2017-08-22.
//
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameTxtFld: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if nameTxtFld?.text != ""{
            Auth.auth().signInAnonymously(completion: { (user, error) in
                if let err = error{
                    print(err.localizedDescription)
                    return
                } else{
                self.performSegue(withIdentifier: "goToMainView", sender: nil)
                }
            })
        }

    }
    
}
