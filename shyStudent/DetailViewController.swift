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


class DetailViewController: UIViewController

{
    
    var channelRef: DatabaseReference?
    var channel: Channel? {
        didSet{
            title = channel?.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }


    
    // MARK: - Navigation
    


}
