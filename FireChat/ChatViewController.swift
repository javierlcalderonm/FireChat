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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
//        configureTableView()
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let error as NSError {
            print("Error al realizar Log Out:" + error.localizedDescription)
        }
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textArray = ["akjshdjfa fja daa f ads f asdf kf","2 akjshdjfa fja daa f ads f asdf kfajs dfkahskjd fkjadsfkj  jskkjsk a sjdkjk asjdkj ka akjd","3 akjshdjfa fja daa f ads f asdf kfajs dfkdkjk asjdkj ka akjd ds f asdf kfajs ds f asdf kfajs dfkdkjk asjdkj ka akjd dfkdkjk asjdkj ka akjd"]
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        cell.messageLabel.text = textArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
//    func configureTableView() {
//        messagesTableView.rowHeight = UITableViewAutomaticDimension
//        messagesTableView.estimatedRowHeight = 120.0
//    }
    
}
