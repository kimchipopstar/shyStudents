//
//  DetailViewController.swift
//  
//
//  Created by Jaewon Kim on 2017-08-22.
//
//

import UIKit
import Firebase
import FirebaseDatabase
import JSQMessagesViewController



class DetailViewController: JSQMessagesViewController
{
    @IBOutlet weak var userInputTxtFld: UITextField!
    var channelRef: DatabaseReference?
    
    var channel: Channel? {
        didSet{
            title = channel?.name
        }
    }
    
    var ref:DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = Auth.auth().currentUser?.uid
        self.senderDisplayName = "Test";
    }


    @IBAction func sendButton(_ sender: UIButton) {
        
        
        let childRef = channelRef?.childByAutoId()
        let values = ["text": userInputTxtFld.text!]
        childRef?.updateChildValues(values)
        
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        //SENDING
    }

    // MARK: - Navigation
    


}
