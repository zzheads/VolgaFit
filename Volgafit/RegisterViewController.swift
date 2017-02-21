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
    var profile: Profile?
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var roleSC: UISegmentedControl!
    
    private enum RoleType: Int {
        case admin = 0
        case trainer = 1
        case client = 2
        
        var role: Role {
            switch self {
            case .admin: return Role(name: "ADMIN")
            case .trainer: return Role(name: "TRAINER")
            case .client: return Role(name: "CLIENT")
            }
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        guard
            let registeredUsernames = self.registeredUsernames,
            let username = usernameTF.text,
            let email = emailTF.text,
            let password = passwordTF.text,
            let confirm = confirmPasswordTF.text,
            !username.isEmpty,
            !email.isEmpty,
            !password.isEmpty,
            !confirm.isEmpty
            else {
                return
        }
        if password != confirm {
            showAlert(title: "Ошибка", message: "Пароль и подтверждение пароля должны совпадать", style: .alert)
            return
        }
        if registeredUsernames.contains(username) {
            showAlert(title: "Ошибка регистрации", message: "Пользователь с таким именем \(username) уже зарегистрирован.", style: .alert)
            return
        }
        let role = RoleType(rawValue: roleSC.selectedSegmentIndex)?.role
        let newUser = User(username: username, password: password, email: email, role: role, profile: self.profile)
        print("\(profile?.json)")
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
    
    func delegateForProfile(profile: Profile) {
        self.profile = profile
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else {
            return
        }
        if (segueId == "toEditProfile") {
            let controller = segue.destination as? EditProfileViewController
            controller?.delegate = self.delegateForProfile
        }
    }
}

extension RegisterViewController {

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func profileButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toEditProfile", sender: self)
    }

}
