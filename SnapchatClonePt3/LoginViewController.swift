//
//  LoginViewController.swift
//  SnapchatClonePt3
//
//  Created by SAMEER SURESH on 3/19/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Checks if user is already signed in and skips login
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegue(withIdentifier: "loginToMain", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
        TODO:
        
        Implement login functionality using the Firebase Auth function for signing in.
        You should check the result of the function call to see if it completes without error.
        If an error occurs, display a message using a UIAlertController (e.g. "Sign in failed, try again")
        Otherwise, perform a segue to the rest of the app using the identifier "loginToMain"
     
    */
    @IBAction func didAttemptLogin(_ sender: UIButton) {
        guard let emailText = emailField.text else { return }
        guard let passwordText = passwordField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: emailText, password: passwordText) { (user, error) in
            
            if error == nil {
                
                //Print into the console if successfully logged in
                //print("You have successfully logged in")
                
                //Go to the HomeViewController if the login is sucessful
                //let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                //self.present(vc!, animated: true, completion: nil)
                self.performSegue(withIdentifier: "loginToMain", sender: nil)
            } else {
                
                //Tells the user that there is an error and then gets firebase to tell them the error
                let alertController = UIAlertController(title: "Error", message: "Sign in failed, try again", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        // YOUR CODE HERE Done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
