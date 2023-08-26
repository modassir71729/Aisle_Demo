//
//  ViewController.swift
//  Aisle_Assignment
//
//  Created by apple on 25/08/23.
//

import UIKit
import Alamofire

class PhoneNumberVc: UIViewController, UITextFieldDelegate {
//MARK: - Outlet
    @IBOutlet weak var phoneNumberTxtFld: UITextField!
    @IBOutlet weak var countryCodeTxtFld: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var countryCodeTitleView: UIView!
    @IBOutlet weak var PhoneNumberTitle: UILabel!
    @IBOutlet weak var getOtpTitle: UILabel!
    
    var phoneNumber = String()
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _setUpUI()
    }
    
    //MARK: - Setup UI
    func _setUpUI(){
        phoneNumberTxtFld.delegate = self
        countryCodeTxtFld.delegate = self
        continueBtn.layer.cornerRadius = 15.0
        continueBtn.clipsToBounds = true
    }
    
    //MARK: - Button Action
    @IBAction func continueBtnTapped(_ sender: UIButton) {
        if countryCodeTxtFld.text == "" {
            let alert = UIAlertController(title: "Enter your country code", message: "", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default) { _ in
            }
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
            
        }else if phoneNumberTxtFld.text == "" {
            let alert = UIAlertController(title: "Enter your Phone Number", message: "", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default) { _ in
            }
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
        } else {
            let storyBoard = AppStoryboard.main.instance
            let OtpVc = storyBoard.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
            if let text1 = countryCodeTxtFld.text, let text2 = phoneNumberTxtFld.text {
                phoneNumber = text1 + text2
            }
            OtpVc.contryCode = countryCodeTxtFld.text ?? ""
            OtpVc.phonePhoneNo = phoneNumberTxtFld.text ?? ""
            NetworkManager.shared.sendPhoneNumber(number: phoneNumber) { result in
                switch result {
                case .success(let result):
                    print("result",result)
                    self.navigationController?.pushViewController(OtpVc, animated: true)
                case .failure(let error):
                    print("Error: \(error)")
                    let alert = UIAlertController(title: "Network Error", message: "", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .default) { _ in
                    }
                    alert.addAction(okayAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

