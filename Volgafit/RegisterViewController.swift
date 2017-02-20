//
//  RegisterViewController.swift
//  Volgafit
//
//  Created by Alexey Papin on 19.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    var registeredUsernames: [String]?
    let apiClient = APIClient()
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        guard
            let registeredUsernames = self.registeredUsernames,
            let username = usernameTF.text,
            let password = passwordTF.text,
            !username.isEmpty,
            !password.isEmpty
            else {
                return
        }
        if registeredUsernames.contains(username) {
            showAlert(title: "Ошибка регистрации", message: "Пользователь с таким именем \(username) уже зарегистрирован.", style: .alert)
            return
        }
        let newUser = User(username: username, password: password, email: "")
        apiClient.get(endpoint: VolgofitEndpoint.user(id: nil, user: newUser)) {(user: User?) in
            guard let user = user else {
                self.showAlert(title: "Ошибка регистрации", message: "Не могу зарегистрировать нового пользователя \(newUser).", style: .alert)
                return
            }
            self.showAlertAndDismiss(title: "Подтвердите адрес", message: "Новый пользователь \(user.username) зарегистрирован, для его активации необходимо подтвердить Ваш адрес электронной почты. Соответствующее письмо отправлено на Ваш адрес.", style: .alert)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiClient.getArray(endpoint: VolgofitEndpoint.user(id: nil, user: nil)) {(users: [User]?) in
            guard let users = users else {
                print("Something wrong")
                return
            }
            print(users)
            self.registeredUsernames = []
            for user in users {
                self.registeredUsernames?.append(user.username)
            }
        }
    }
}
