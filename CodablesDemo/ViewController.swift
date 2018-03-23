//
//  ViewController.swift
//  CodablesDemo
//
//  Created by Appinventiv on 22/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var repositoryLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
//    @IBOutlet weak var trailing: NSLayoutConstraint!
//    @IBOutlet weak var leading: NSLayoutConstraint!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.informationView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchButton(_ sender: UIButton) {
       // OperationQueue.main.addOperation {
       
            if self.searchTextField.text!.isEmpty == true{
                self.toDisplayAlert(messageToDisplay: "Enter something to search")
            }
            else{
                let userText = self.searchTextField.text!
                NetworkController().fetchData(searchedText: userText){ (dataRequired) in
                    self.storeData(dataDict:dataRequired)
                    //                    self.leading.constant = 20
                    //                    self.trailing.constant = 20
                    UIView.animate(withDuration: 1, delay: 0, options: .transitionCurlDown, animations: {
                        DispatchQueue.main.async {
                            self.informationView.isHidden = false
                             self.view.layoutIfNeeded()
                        }
                        
                    }, completion: nil)
                    }
        }
        
    }

    
    func toDisplayAlert(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Error Message!", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func storeData(dataDict : [String:Any])
    {
        DispatchQueue.main.async {
            self.profileImageView.image = dataDict["profile"] as? UIImage
            self.nameLabel.text = dataDict["name"] as? String
            self.userNameLabel.text = dataDict["login"] as? String
            self.companyLabel.text = dataDict["company"] as? String
            self.followersLabel.text = "\(dataDict["followers"] ?? "0")"
            self.locationLabel.text = dataDict["location"] as? String
            self.repositoryLabel.text = "\(dataDict["repos"] ?? "0")"

        }
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.searchTextField.text = ""
//        self.leading.constant = -400
//        self.trailing.constant = 400
        UIView.animate(withDuration: 1) {
            self.informationView.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
}

