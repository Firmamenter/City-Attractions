//
//  LoginViewController.swift
//  McCollins
//
//  Created by Da Chen on 1/6/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

import UIKit
import Eureka
import SVProgressHUD

class LoginViewController: FormViewController {
    var emailTxt: String?
    var pwdTxt: String?

    @IBOutlet weak var signinBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        signinBtn.layer.cornerRadius = 5
        signinBtn.layer.borderWidth = 1.8
        signinBtn.layer.borderColor = UIColor.white.cgColor
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        
        form
        +++ Section()
        
        <<< EmailFloatLabelRow() {
            $0.title = "Email Id"
            $0.cell.height = { 48 }
            $0.add(rule: RuleRequired())
            $0.add(rule: RuleEmail())
        }
        .cellUpdate { cell, row in
            if !row.isValid {
                cell.floatLabelTextField.titleTextColour = UIColor.red
            }
            self.emailTxt = cell.textField.text
        }
        
        <<< SpaceCellRow() {
            $0.cell.spaceHeight = 10
            $0.cell.backgroundColor = .clear
        }
        
        <<< PasswordFloatLabelRow() {
            $0.title = "Password"
            $0.cell.height = { 48 }
        }
        .cellUpdate({ (cell, row) in
            self.pwdTxt = cell.textField.text
        })
    }
    
    @IBAction func signin(_ sender: UIButton) {
        guard let email = emailTxt,
            let pwd = pwdTxt else {
                showAlert(title: "Oops", msg: "Please type in email and password!")
                return
        }
        SVProgressHUD.show()
        WebManager.shared.checkLogin(email: email, pwd: pwd) { (json) in
            if json.count == 0 {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.showAlert(title: "Failed", msg: "Sorry we can't find this user, please check your info.")
                }
            } else {
                WebParser.shared.parseUserInfo(jsonObj: json)
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeScreen = storyboard.instantiateViewController(withIdentifier: "HomeNavi")
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.6, options: UIView.AnimationOptions.transitionFlipFromRight, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = homeScreen
                    }, completion: nil)
                }
            }
        }
    }
}
