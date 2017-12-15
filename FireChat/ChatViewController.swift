//
//  ChatViewController.swift
//  FireChat
//
//  Created by Javier Calderon on 12/12/17.
//  Copyright © 2017 Javier Calderon. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    let databaseNameKey = "Messages"
    let databaseBodyKey = "MessageBody"
    let databaseSenderKey = "Sender"
    var messagesArray : [Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        messagesTableView.separatorStyle = .none
        
        retrieveMessages()
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let error as NSError {
            print("Error al realizar Log Out:" + error.localizedDescription)
        }
    }
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
       
        if let message =  messageTextField.text
        {
            messageTextField.endEditing(true)
            
            // Send message to Firebase
            messageTextField.isEnabled = false
            sendMessageButton.isEnabled = false
            
            let messageDatabase = Database.database().reference().child(databaseNameKey)
            let messageDictionary = [databaseSenderKey:Auth.auth().currentUser?.email, databaseBodyKey:message]
            
            messageDatabase.childByAutoId().setValue(messageDictionary, withCompletionBlock: {
                (error, reference) in
                if error != nil
                {
                    print(error!.localizedDescription)
                } else {
                    print("Message Saved")
                    self.messageTextField.isEnabled = true
                    self.sendMessageButton.isEnabled = true
                }
            })
        }
        
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let textArray = ["akjshdjfa fja daa f ads f asdf kf","2 akjshdjfa fja daa f ads f asdf kfajs dfkahskjd fkjadsfkj  jskkjsk a sjdkjk asjdkj ka akjd","3 akjshdjfa fja daa f ads f asdf kfajs dfkdkjk asjdkj ka akjd ds f asdf kfajs ds f asdf kfajs dfkdkjk asjdkj ka akjd dfkdkjk asjdkj ka akjd"]
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
//        cell.messageLabel.text = textArray[indexPath.row]

        cell.messageLabel.text = messagesArray[indexPath.row].messageBody
        cell.userNameLabel.text = messagesArray[indexPath.row].sender
        
        if cell.userNameLabel.text == Auth.auth().currentUser?.email as String! {
            cell.backgroundColor = UIColor.orange
        }else{
            cell.backgroundColor = UIColor.lightGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count //3
    }
    
    // MARK: Utils
    
    func retrieveMessages()
    {
        let messagesDatabase = Database.database().reference().child(databaseNameKey)
        messagesDatabase.observe(.childAdded) {
            (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue[self.databaseBodyKey]!
            let sender = snapshotValue[self.databaseSenderKey]!
            let message = Message()
            
            message.sender = sender
            message.messageBody = text
            
            self.messagesArray.append(message)
            self.messagesTableView.reloadData()
        }
    }
    
}
