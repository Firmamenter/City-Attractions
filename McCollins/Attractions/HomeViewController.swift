//
//  HomeViewController.swift
//  McCollins
//
//  Created by Da Chen on 1/6/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class HomeViewController: UIViewController {
    var attractions: [AttractionDetail] = []
    var imgs: [UIImage?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tbView.reloadData()
            }
        }
    }

    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var settingBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SVProgressHUD.show()
        setupUI()
        WebManager.shared.getAttractions(email: UserDefaults.standard.string(forKey: "Email")!) { (attractionList) in
            if attractionList.count == 0 {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.showAlert(title: "Failed", msg: "Sorry we can't fetch any data right now, please try again later.")
                }
            } else {
                self.attractions = WebParser.shared.parseAttractions(jsonObj: attractionList)!
                for attraction in self.attractions {
                    self.imgs.append(WebManager.shared.getImgs(imgUrl: attraction.image!))
                }
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    func setupUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        tbView.delegate = self
        tbView.dataSource = self
        tbView.tableFooterView = UIView()
        tbView.allowsSelection = false
        settingBtn.layer.cornerRadius = 5
        settingBtn.layer.borderWidth = 1.8
        settingBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    @objc func callTel(sender: UIButton) {
        let phoneNumber = self.attractions[sender.tag].contact!
        
        let alertController = UIAlertController(title: nil, message: phoneNumber, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (cancelAction) in
            alertController.dismiss(animated: true, completion: nil)
        }
        let callAction = UIAlertAction(title: "Call", style: .default) { (callAction) in
//            guard let number = URL(string: "tel://" + phoneNumber) else {
//                print("Error")
//                return
//            }
//            UIApplication.shared.open(number)
            if let url = URL(string: "tel://\(phoneNumber)"),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler:nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            } else {
                print("Error")
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(callAction)
        self.present(alertController, animated: true)
    }
    
    @objc func openWeb(sender: UIButton) {
        let url = attractions[sender.tag].sitelink
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let webVC = storyboard.instantiateViewController(withIdentifier: "WebVC") as! WebPageViewController
        webVC.url = url
        navigationController?.pushViewController(webVC, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attractionCell", for: indexPath) as! AttractionCell
        cell.attractionTitle.text = "Name: " + attractions[indexPath.row].title!
        cell.des.text = attractions[indexPath.row].description
        cell.timing.text = "Timing: " + attractions[indexPath.row].timing!
        let lat = Double(attractions[indexPath.row].latitude!)!
        let log = Double(attractions[indexPath.row].longitude!)!
        let coordinate0 = CLLocation(latitude: lat, longitude: log)
        let coordinate1 = CLLocation(latitude: 41.8781, longitude: 87.6298)
        let distanceInMeters = coordinate0.distance(from: coordinate1)
        cell.distance.text = "Distance: " + String(Int(distanceInMeters/1000)) + " KM"
        cell.img.makeCircle()
        if imgs.count == attractions.count {
            cell.img.image = imgs[indexPath.row]
        }
        cell.callBtn.tag = indexPath.row
        cell.callBtn.addTarget(self, action: #selector(callTel(sender:)), for: .touchUpInside)
        cell.webBtn.tag = indexPath.row
        cell.webBtn.addTarget(self, action: #selector(openWeb(sender:)), for: .touchUpInside)
        return cell
    }
}
