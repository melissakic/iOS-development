//
//  WelcomeViewController.swift
//  TODO list
//
//  Created by Melis on 11. 12. 2022..
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {


    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp.layer.borderWidth=1.0
        signUp.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        signUp.layer.cornerRadius=40;
        login.layer.cornerRadius=40
    }

}
