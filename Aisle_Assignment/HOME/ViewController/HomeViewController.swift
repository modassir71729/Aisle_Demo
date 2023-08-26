//
//  HomeViewController.swift
//  Aisle_Assignment
//
//  Created by apple on 26/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
//MARK: - Outlet
    
    @IBOutlet weak var intrestedProfileCollectionView: UICollectionView!
    @IBOutlet weak var meenaImgView: UIImageView!
    @IBOutlet weak var upgradeBtn: UIButton!
    
//MARK: - Property
    var authToken = String()
    let itemArr = ["beena_Img", "teena_Img", "beena_Img", "teena_Img", "beena_Img", "teena_Img"]
    
 //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _apiCall()
        _setUI()
        registerCell()
        setDelegate()
    }
    
//MARK: - Register collectionView Cell
    func registerCell(){
        intrestedProfileCollectionView.registerNib(of: intrestedProfileCell.self)
    }
//MARK: - SetDelegate
    
    func setDelegate(){
        intrestedProfileCollectionView.delegate = self
        intrestedProfileCollectionView.dataSource = self
    }
//MARK: - SetUp UI
    func _setUI(){
        upgradeBtn.layer.cornerRadius = 10.0
        upgradeBtn.clipsToBounds = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if let layout = intrestedProfileCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.minimumInteritemSpacing = 1 // Adjust as needed
                   layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
               }

    }
    //MARK: - Api Call
    func _apiCall(){
        NetworkManager.shared.fetchHomeData(headers: authToken) { result in
            switch result {
               case .success(let post):
                   print("Fetched Post: \(post)")
               case .failure(let error):
                   print("Error: \(error)")
               }
        }
    }
}
//MARK: - Deleagtes, Datasource and DelegateFlowLayout Method

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getCell(indexPath: indexPath) as intrestedProfileCell
        cell.itemImg.image = UIImage(named: "\(itemArr[indexPath.row])")
        return cell
    }
}
//MARK: - DelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return(CGSize(width: 168, height: 255))
    }
}
