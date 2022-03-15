//
//  ViewController.swift
//  Lesson 2.3.1 - login form with different views
//
//  Created by Алексей Верховых on 08.03.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var inputUserName: UITextField!
    @IBOutlet var inputPassword: UITextField!
    
    private let userName = "admin"
    private let password = "password"

    override func viewDidLoad() {
        super.viewDidLoad()
     
        inputUserName.delegate = self
        inputUserName.returnKeyType = .next
   
        inputPassword.delegate = self
        inputPassword.returnKeyType = .done
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let accountTabBarViewController = segue.destination as? UITabBarController else { return }
        for viewContoller in accountTabBarViewController.children {
            guard let accountViewContoller = viewContoller as? AccountViewController else { return }
            accountViewContoller.userName = inputUserName.text
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        clearInputs()
    }
    
    @IBAction func logInButtonClicked() {
        if !canLogin() {
            
            alertWithAction(
                title: "Incorrect",
                description: "Incorrect Username or Password",
                buttonTitle: "Try again"
            )
            
            clearInputs()
            
            inputUserName.becomeFirstResponder()
            
            
            
            return
        }
    
        performSegue(withIdentifier: "accountSegue", sender: nil)
    }
    
    @IBAction func forgotUserNameButtonClicked() {
        alertWithAction(
            title: "Okay",
            description: "UserName is \"\(userName)\"",
            buttonTitle: "Ok"
        )
    }
    
    @IBAction func forgotPasswordButtonClicked() {
        alertWithAction(
            title: "Okay",
            description: "Password is \"\(password)\"",
            buttonTitle: "Ok"
        )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == inputPassword {
            logInButtonClicked()
        } else if textField == inputUserName {
            inputPassword.becomeFirstResponder()
        }
        return true
    }
    
    private func canLogin() -> Bool {
        inputUserName.text == userName && inputPassword.text == password
    }
    
    private func alertWithAction(title: String, description: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        present(alert, animated: true)
    }
    
    private func clearInputs() {
        inputPassword.text = ""
        inputUserName.text = ""
    }
    
}

extension MainViewController: UITextFieldDelegate {
    
    
}
