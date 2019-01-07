//
//  ProfileViewController.swift
//  McCollins
//
//  Created by Da Chen on 1/7/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

import UIKit
import Eureka

class ProfileViewController: FormViewController {
    var firstNameTxt: String?
    var lastNameTxt: String?
    var emailTxt: String?
    var phoneTxt: String?
    var pwdTxt: String?
    var cpwdTxt: String?
    var dobTxt: String?
    var gender: String?
    var imgPicker = UIImagePickerController()

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        title = "EDIT PROFILE"
        tableView.isScrollEnabled = false
        imgPicker.delegate = self
        imgPicker.sourceType = .photoLibrary
        submitBtn.layer.cornerRadius = 5
        submitBtn.layer.borderWidth = 1.8
        submitBtn.layer.borderColor = UIColor.white.cgColor
        profileImg.makeCircle()
        
        form
            +++ Section()
            
            <<< TextFloatLabelRow() {
                $0.title = "First Name"
                $0.cell.textField.text = UserDefaults.standard.string(forKey: "FirstName")
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
                $0.cell.textField.text = UserDefaults.standard.string(forKey: "LastName")
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
                $0.cell.textField.text = UserDefaults.standard.string(forKey: "Email")
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
                $0.cell.textField.text = UserDefaults.standard.string(forKey: "Phone")
                $0.cell.height = { 48 }
                }
                .cellUpdate { cell, row in
                    self.phoneTxt = cell.textField.text
            }
            
            <<< SpaceCellRow() {
                $0.cell.spaceHeight = 10
                $0.cell.backgroundColor = .clear
            }
            
            <<< TextFloatLabelRow() {
                $0.title = "DOB"
                $0.cell.textField.text = UserDefaults.standard.string(forKey: "Dob")
                $0.cell.height = { 48 }
                }
                .cellUpdate { cell, row in
                    self.dobTxt = cell.textField.text
        }
    }
    
    @IBAction func editImg(_ sender: UIButton) {
        self.present(imgPicker, animated: true)
    }
    
    @IBAction func submitUpdates(_ sender: UIButton) {
    }
}

extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[.originalImage] as! UIImage
        profileImg.image = img
        imgPicker.dismiss(animated: true, completion: nil)
    }
}
