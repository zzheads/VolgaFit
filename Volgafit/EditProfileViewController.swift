//
//  EditProfileViewController.swift
//  Volgafit
//
//  Created by Alexey Papin on 20.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation
import UIKit

class EditProfileViewController: UIViewController {
    var user: User?
    var delegate: ((Profile) -> Void)?
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var roleSC: UISegmentedControl!
    @IBOutlet weak var sexSC: UISegmentedControl!
    @IBOutlet weak var photoImageView: UIImageView!
    
}

extension EditProfileViewController {
    @IBAction func imagePressed(_ sender: Any) {
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard
            let firstname = firstNameTF.text,
            let lastname = lastNameTF.text,
            let heightText = heightTF.text,
            let weightText = weightTF.text,
            !firstname.isEmpty,
            !lastname.isEmpty,
            let height = Double(heightText),
            let weight = Double(weightText)
            else {
                return
        }
        guard
            let user = self.user,
            let delegate = self.delegate
            else {
                self.dismiss(animated: true)
                return
        }
        let profile = Profile(id: 0, user: user, firstName: firstname, lastName: lastname, height: height, weight: weight, imagePath: nil, birthDate: nil, street: nil, city: nil, country: nil, zipCode: nil, phone: nil, social: nil, trainerOf: nil, clientOf: nil)
        delegate(profile)
        self.dismiss(animated: true)
    }
}
