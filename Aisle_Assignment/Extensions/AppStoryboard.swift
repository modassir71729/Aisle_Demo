//
//  AppStoryboard.swift
//  Aisle_Assignment
//
//  Created by apple on 26/08/23.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case main = "Main"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
}
