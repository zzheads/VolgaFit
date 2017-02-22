//
//  ViewController.swift
//  Volgafit
//
//  Created by Alexey Papin on 19.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import UIKit

let USERNAME_KEY = "username"
let PASSWORD_KEY = "password"
let REMEMBERME_KEY = "rememberme"

class LoginViewController: UIViewController {
    let apiClient = APIClient()
    var loggedUser: User?
    var rememberMe: Bool = false
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var rememberButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDefaults()
        self.updateRememberMeButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.rememberMe {
            self.saveDefaults()
        } else {
            self.dropDefaults()
        }
        guard let segueId = segue.identifier else {
            return
        }
        if (segueId == "toNewsScreen") {
            let controller = segue.destination as? NewsViewController
            controller?.loggedUser = self.loggedUser
        }
    }
}

extension LoginViewController {
    fileprivate func loadDefaults() {
        guard
            let username = UserDefaults.standard.value(forKey: USERNAME_KEY) as? String,
            let password = UserDefaults.standard.value(forKey: PASSWORD_KEY) as? String,
            let rememberMe = UserDefaults.standard.value(forKey: REMEMBERME_KEY) as? Bool
            else {
                return
        }
        self.usernameTF.text = username
        self.passwordTF.text = password
        self.rememberMe = rememberMe
    }
    
    fileprivate func saveDefaults() {
        UserDefaults.standard.set(self.usernameTF.text, forKey: USERNAME_KEY)
        UserDefaults.standard.set(self.passwordTF.text, forKey: PASSWORD_KEY)
        UserDefaults.standard.set(self.rememberMe, forKey: REMEMBERME_KEY)
    }
    
    fileprivate func dropDefaults() {
        UserDefaults.standard.removeObject(forKey: USERNAME_KEY)
        UserDefaults.standard.removeObject(forKey: PASSWORD_KEY)
        UserDefaults.standard.removeObject(forKey: REMEMBERME_KEY)
    }
}

extension LoginViewController {
    
    @IBAction func rememberMeToggle(_ sender: Any) {
        self.rememberMe = !rememberMe
        self.updateRememberMeButton()
    }
    
    fileprivate func updateRememberMeButton() {
        if self.rememberMe {
            rememberButton.setTitle("[X]", for: .normal)
        } else {
            rememberButton.setTitle("[ ]", for: .normal)
        }
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        guard
            let username = usernameTF.text,
            let password = passwordTF.text,
            !username.isEmpty,
            !password.isEmpty
            else {
                return
        }
        let user = User(username: username, password: password, email: "")
        apiClient.get(endpoint: VolgofitEndpoint.login(user: user)) {(loginResult: ApiResult?) in
            guard let loginResult = loginResult else {
                print("Something wrong")
                return
            }
            if (!loginResult.success) {
                if (loginResult.message == "User is disabled") {
                    self.showAlertAndAsk(title: "Ошибка",
                                         message: "Пользователь не активирован. Для активации необходимо подтвердить адрес электронной почты. Выслать Вам письмо с ссылкой подверждения?", style: .alert) { ok in
                                            if (ok) {
                                                self.apiClient.get(endpoint: VolgofitEndpoint.sendmail(username: username)) {(mailResult: ApiResult?) in
                                                    guard let mailResult = mailResult else {
                                                        print("Cand send mail")
                                                        return
                                                    }
                                                    print(mailResult.json)
                                                    self.showAlert(title: "Письмо отправлено", message: "Пожалуйста, активируйте пользователя \(username) перейдя но ссылке указанной в письме.", style: .alert)
                                                }
                                            }
                    }
                } else {
                    self.showAlert(title: "Ошибка", message: "Не могу войти, \(loginResult.message). Неверная пара username/password.", style: .alert)
                }
                return
            }
            else {
                self.loggedUser = user
                print("\(loginResult.json)")
                self.performSegue(withIdentifier: "toNewsScreen", sender: self)
            }
        }
    }
}

