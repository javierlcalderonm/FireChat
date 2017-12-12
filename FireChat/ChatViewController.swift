//
//  ChatViewController.swift
//  FireChat
//
//  Created by Javier Calderon on 12/12/17.
//  Copyright © 2017 Javier Calderon. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let error as NSError {
            print("Error al realizar Log Out:" + error.localizedDescription)
        }
    }
    
}
