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

    var channelRef: DatabaseReference?
    var channel: Channel? {
        didSet{
            title = channel?.name
        }
    }
    var messages = [JSQMessage]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = Auth.auth().currentUser?.uid
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        //SENDING -> Firebase (under the child channel)
    }

    // MARK: - Navigation
    


}
