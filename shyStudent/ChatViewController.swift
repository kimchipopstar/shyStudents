//
//  ChatViewController.swift
//  shyStudent
//
//  Created by Jaewon Kim on 2017-08-21.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        post()
    }
    
    func post(){
    
        let title = "Title"
        let message = "Message"
        
        let post : [String : Any] = ["title" : title,
                                           "message" : message]
        
        let databaseRef = Database.database().reference()
        
        databaseRef.child("Posts").childByAutoId().setValue(post)
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
