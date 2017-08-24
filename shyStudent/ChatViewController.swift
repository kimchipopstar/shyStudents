//
//  ChatViewController.swift
//  shyStudent
//
//  Created by Jaewon Kim on 2017-08-21.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

enum Section: Int {
    case createNewChannelSection = 0
    case currentChannelsSection
}

class ChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var channelRef: DatabaseReference = Database.database().reference().child("channels")
    private var channelRefHandel: DatabaseHandle?
    
    // MARK: Properties
    
    var senderDisplayName: String?
    var newChannelTextField: UITextField?
    private var channels: [Channel] = []
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CLASS"
        observeChannels()

    }
    
    
    deinit {
        if let refHandle = channelRefHandel {
            channelRef.removeObserver(withHandle: refHandle)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.automaticallyAdjustsScrollViewInsets = false
    }

    
    // MARK: tableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentSection: Section = Section(rawValue: section){
            switch currentSection {
            case .createNewChannelSection:
                return 1
                
            case .currentChannelsSection:
                return channels.count
            }
        } else{
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue ? "NewChannel" : "ExistingChannel"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue{
            if let createNewChannelCell = cell as? CreateChannelCell {
                newChannelTextField = createNewChannelCell.newChannelNameField
            }
        } else if (indexPath as NSIndexPath).section == Section.currentChannelsSection.rawValue{
            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
        }
        
        
        return cell
    }
    
    // MAKR: tableview delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == Section.currentChannelsSection.rawValue{
            let channel = channels[(indexPath as NSIndexPath).row]
            
            self.performSegue(withIdentifier: "ShowChannel", sender: channel)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let key = channels[(indexPath as NSIndexPath).row].id
            print(key)
            channelRef.child(key).removeValue { (error, ref) in
                if error != nil {
                    print("error yo")
                }
            }
            channels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)


            tableView.reloadData()
        }
    }
    
    // MAKR: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let channel = sender as? Channel {
            if let detailVC = segue.destination as? DetailViewController{
                
                detailVC.senderDisplayName = senderDisplayName
                detailVC.channel = channel
                detailVC.channelRef = channelRef.child(channel.id)
                detailVC.title = channel.name
            }
        }
    }
    
    
    // MARK: firebase methods
    
    private func observeChannels(){
        
        channelRefHandel = channelRef.observe(.childAdded, with: { (snapshot) -> Void in
            let channelData = snapshot.value as! Dictionary<String, AnyObject>
            let id = snapshot.key
            if let name = channelData["name"] as! String!, name.characters.count > 0 {
                self.channels.append(Channel(id: id, name: name))
                self.tableView.reloadData()
            } else {
                print("Error! Could not decode channel data")
            }
        })
        
        channelRefHandel = channelRef.observe(.childRemoved, with: { (snapshot) -> Void in
            let channelData = snapshot.value as! Dictionary<String, AnyObject>
            let id = snapshot.key
            if let name = channelData["name"] as! String!, name.characters.count > 0 {
                let myChannel = Channel(id: id, name: name)
             //Remove channelData from self.channels
                if let index = self.channels.index(of:myChannel) {
                    self.channels.remove(at: index)
                }
                self.tableView.reloadData()
            } else {
                print("Error! Could not decode channel data")
            }
        })
        
    }
    
    // MAKR: action
    
    @IBAction func createChannel(_ sender: UIButton) {
        
        if let name = newChannelTextField?.text {
            
            let newChannelRef = channelRef.childByAutoId()
            
            let channelItem = ["name": name]
            
            newChannelRef.setValue(channelItem)
        }
    }
}

