//
//  SettingViewController.swift
//  McCollins
//
//  Created by Da Chen on 1/7/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tbView.delegate = self
        tbView.dataSource = self
        tbView.tableFooterView = UIView()
        tbView.isScrollEnabled = false
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            UserDefaults.standard.set(false, forKey: "LoggedIn")
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signupScreen = storyboard.instantiateViewController(withIdentifier: "SignupNavi")
            UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.6, options: UIView.AnimationOptions.transitionFlipFromRight, animations: {
                UIApplication.shared.keyWindow?.rootViewController = signupScreen
            }, completion: nil)
        } else {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
            navigationController?.pushViewController(profileVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Settings"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = indexPath.row == 0 ? "USER PROFILE" : "LOGOUT"
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
}
