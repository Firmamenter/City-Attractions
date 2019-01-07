//
//  SignUpViewController.swift
//  McCollins
//
//  Created by Da Chen on 1/3/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

import UIKit
import Eureka
import DLRadioButton
import SVProgressHUD

class SignUpViewController: FormViewController {
    var firstNameTxt: String?
    var lastNameTxt: String?
    var emailTxt: String?
    var phoneTxt: String?
    var pwdTxt: String?
    var cpwdTxt: String?
    var dobTxt: String?
    var gender: String?

    @IBOutlet weak var male: DLRadioButton!
    @IBOutlet weak var female: DLRadioButton!
    @IBOutlet weak var submit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        title = "SIGN UP"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        male.titleLabel?.text = "Male"
        female.titleLabel?.text = "Female"
        submit.layer.cornerRadius = 5
        submit.layer.borderWidth = 1.8
        submit.layer.borderColor = UIColor.white.cgColor
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        
        form
        +++ Section()
        
        <<< TextFloatLabelRow() {
            $0.title = "First Name"
            $0.cell.height = { 48 }
        }
        .cellUpdate { cell, row in
            self.firstNameTxt = cell.textField.text
        }
            
        <<< SpaceCellRow() {
            $0.cell.spaceHeight = 10
            $0.cell.backgroundColor = .clear
        }
        
        <<< TextFloatLabelRow() {
            $0.title = "Last Name"
            $0.cell.height = { 48 }
        }
        .cellUpdate { cell, row in
            self.lastNameTxt = cell.textField.text
        }
            
        <<< SpaceCellRow() {
            $0.cell.spaceHeight = 10
            $0.cell.backgroundColor = .clear
        }
        
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
            
        <<< PhoneFloatLabelRow() {
            $0.title = "Phone No"
            $0.cell.height = { 48 }
        }
        .cellUpdate { cell, row in
            self.phoneTxt = cell.textField.text
        }
            
        <<< SpaceCellRow() {
            $0.cell.spaceHeight = 10
            $0.cell.backgroundColor = .clear
        }
        
        <<< PasswordFloatLabelRow() {
            $0.title = "Password"
            $0.cell.height = { 48 }
        }
        .cellUpdate { cell, row in
            self.pwdTxt = cell.textField.text
        }
            
        <<< SpaceCellRow() {
            $0.cell.spaceHeight = 10
            $0.cell.backgroundColor = .clear
        }
            
        <<< PasswordFloatLabelRow() {
            $0.title = "Confirm Password"
            $0.cell.height = { 48 }
        }
        .cellUpdate { cell, row in
            self.cpwdTxt = cell.textField.text
        }
            
        <<< SpaceCellRow() {
            $0.cell.spaceHeight = 10
            $0.cell.backgroundColor = .clear
        }
        
        <<< TextFloatLabelRow() {
            $0.title = "DOB"
            $0.cell.height = { 48 }
        }
        .cellUpdate { cell, row in
            self.dobTxt = cell.textField.text
        }
    }
    
    @IBAction func submitForm(_ sender: UIButton) {
        guard let firstName = firstNameTxt,
            let lastName = lastNameTxt,
            let email = emailTxt,
            let phone = phoneTxt,
            let pwd = pwdTxt,
            let cpwd = cpwdTxt,
            let dob = dobTxt else {
                showAlert(title: "Oops", msg: "Please type in all required info.")
                return
        }
        if male.isSelected {
            gender = "Male"
        } else if female.isSelected {
            gender = "Female"
        } else {
            showAlert(title: "Oops", msg: "Please select your gender.")
            return
        }
        let form = Form(firstName: firstName, lastName: lastName, emailId: email, phone: phone, password: pwd, cpassword: cpwd, dob: dob, gender: gender)
        SVProgressHUD.show()
        WebManager.shared.submitForm(form: form) { (isError) in
            if isError {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.showAlert(title: "Failed", msg: "Sorry we can't create your account, please try again later.")
                }
            } else {
                UserDefaults.standard.set(true, forKey: "LoggedIn")
                UserDefaults.standard.set(firstName, forKey: "FirstName")
                UserDefaults.standard.set(lastName, forKey: "LastName")
                UserDefaults.standard.set(email, forKey: "Email")
                UserDefaults.standard.set(phone, forKey: "Phone")
                UserDefaults.standard.set(pwd, forKey: "Password")
                UserDefaults.standard.set(dob, forKey: "Dob")
                UserDefaults.standard.set(self.gender, forKey: "Gender")
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
