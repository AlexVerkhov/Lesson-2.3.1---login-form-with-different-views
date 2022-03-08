//
//  AccountViewController.swift
//  Lesson 2.3.1 - login form with different views
//
//  Created by Алексей Верховых on 08.03.2022.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet var userHelloLabel: UILabel!
    
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userHelloLabel.text = "Hello, " + userName 
    }
    
}
