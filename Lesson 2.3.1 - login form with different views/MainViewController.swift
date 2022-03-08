//
//  ViewController.swift
//  Lesson 2.3.1 - login form with different views
//
//  Created by Алексей Верховых on 08.03.2022.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

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
        guard let accountViewController = segue.destination as? AccountViewController else { return }
        accountViewController.userName = inputUserName.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        clearInputs()
    }
    
    @IBAction func logInButtonClicked() {
        if !canLogin() {
            
            clearInputs()
            
            // заметил, что если перенести эту строку за вызов алерта, фокус не перейдет
            // на инпут для логина
            inputUserName.becomeFirstResponder()
            
            alertWithAction(
                title: "Incorrect",
                description: "Incorrect Username or Password",
                buttonTitle: "Try again"
            )
            
            return
        }
        
        // похоже, что алерт прерывает сигвей, но меня не покидает чувство, что сделал-таки неверно
        // так как если закомментировать алерт, сигвей все равно пройдет
        // но если я пробую дернуть сигвей вручную - он все равно должен быть связан с какой-то
        // кнопкой... отвязать его от текущей кнопки, сделать невидимую или невидимый элемент навигации?
        // и далее дергать таким образом, как в примере ниже?
        //
        // performSegue(withIdentifier: "accountSegue", sender: nil)
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

