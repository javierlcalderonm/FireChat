//
//  RegisterViewController.swift
//  FireChat
//
//  Created by Javier Calderon on 12/12/17.
//  Copyright © 2017 Javier Calderon. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            messageLabel.text = "Datos incompletos"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let errorValue = error {
                self.messageLabel.text = errorValue.localizedDescription
            }else{
                self.messageLabel.text = "Usuario Registrado"
                self.performSegue(withIdentifier: "GoToChat", sender: self)
            }
        }
    }
}
