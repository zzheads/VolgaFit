//
//  NewsViewController.swift
//  Volgafit
//
//  Created by Alexey Papin on 20.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    let apiClient = APIClient()
    var loggedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let loggedUser = self.loggedUser else {
            return
        }
        print("News controller: logged as \(loggedUser.json)")
    }
}
