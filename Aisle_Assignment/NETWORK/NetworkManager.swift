//
//  NetworkManager.swift
//  Aisle_Assignment
//
//  Created by apple on 26/08/23.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func sendPhoneNumber(number: String, completion: @escaping (Result<Any, Error>) -> Void) {
        
        let url = "https://app.aisle.co/V1/users/phone_number_login"
        let parameters: [String: Any] = [
            "number": number
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func sendOtp(otp: String, number: String, completion: @escaping (Result<ModelOtp, Error>) -> Void) {
        
        let url = "https://app.aisle.co/V1/users/verify_otp"
        let parameters: [String: Any] = [
            "number": number, "otp": otp
        ]
        AF.request(url, method: .post, parameters: parameters)
                .validate()
                .responseDecodable(of: ModelOtp.self) { response in
                    switch response.result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func fetchHomeData(headers: String, completion: @escaping (Result<HomePageModel, Error>) -> Void) {
        
        let url = "https://app.aisle.co/V1/users/test_profile_list"
        
        let headers: HTTPHeaders = [
                "Authorization": "32c7794d2e6a1f7316ef35aa1eb34541",
            ]
        
        AF.request(url, headers: headers)
                .validate()
                .responseDecodable(of: HomePageModel.self) { response in
                    switch response.result {
                    case .success(let post):
                        completion(.success(post))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
}
