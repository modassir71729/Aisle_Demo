//
//  OtpViewController.swift
//  Aisle_Assignment
//
//  Created by apple on 26/08/23.
//

import UIKit
import Alamofire

class OtpViewController: UIViewController {
    
//MARK: - Outlet
    @IBOutlet weak var otpTimerLbl: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var otpTxtFld: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var countryCodeLbl: UILabel!
    
//MARK: - Property
    var contryCode = String()
    var phonePhoneNo = String()
    var phoneNumber = String()
    var remainingSeconds = 60
    var timer: Timer?
    var authToken = String()
    
//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _setUpUI()
        updateCountdownLabel()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdownLabel), userInfo: nil, repeats: true)
    }
//MARK: - Timer Setup
    @objc func updateCountdownLabel() {
            if remainingSeconds > 0 {
                remainingSeconds -= 1
                
                let formatter = DateComponentsFormatter()
                formatter.allowedUnits = [.minute, .second]
                formatter.unitsStyle = .positional
                
                if let formattedString = formatter.string(from: TimeInterval(remainingSeconds)) {
                    otpTimerLbl.text = formattedString
                }
            } else {
                otpTimerLbl.text = "Time's up!"
                timer?.invalidate()
            }
        }
    
 //MARK: - Setup UI
    func _setUpUI(){
        self.countryCodeLbl.text = contryCode
        self.phoneNumberLbl.text = phonePhoneNo
        continueBtn.layer.cornerRadius = 15.0
        continueBtn.clipsToBounds = true
    }
    
//MARK: - Button Action
    @IBAction func continueBtnPress(_ sender: UIButton) {
        if otpTxtFld.text == ""{
            let alert = UIAlertController(title: "Please enter the Otp", message: "", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default) { _ in
            }
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
        }else{
            let storyBoard = AppStoryboard.main.instance
            let homeVc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            if let text1 = countryCodeLbl.text, let text2 = phoneNumberLbl.text {
                phoneNumber = text1 + text2
            }
            homeVc.authToken = authToken
            NetworkManager.shared.sendOtp(otp: otpTxtFld.text ?? "", number: phoneNumber) { result in
                switch result {
                case .success(let post):
                    self.authToken = post.token ?? ""
                    self.navigationController?.pushViewController(homeVc, animated: true)
                case .failure(let error):
                    let alert = UIAlertController(title: "Network Error", message: "", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .default) { _ in
                    }
                    alert.addAction(okayAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
//MARK: - Button Action
    @IBAction func editNumberBtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
