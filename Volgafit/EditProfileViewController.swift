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
    @IBOutlet weak var birthDateTF: UITextField!
    
    @IBOutlet weak var sexSC: UISegmentedControl!
    @IBOutlet weak var photoImageView: UIImageView!

    private enum Sex: Int {
        case male = 0
        case female = 1
        
        var value: String {
            switch self {
            case .male: return "male"
            case .female: return "female"
            }
        }
    }
    
    @IBAction func imagePressed(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        self.navigationController?.present(imagePickerController, animated: true)
    }
 
    @IBAction func savePressed(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"

        guard
            let firstname = firstNameTF.text,
            let lastname = lastNameTF.text,
            let heightText = heightTF.text,
            let weightText = weightTF.text,
            let birthDateString = birthDateTF.text,
            !firstname.isEmpty,
            !lastname.isEmpty,
            !birthDateString.isEmpty,
            let height = Double(heightText),
            let weight = Double(weightText),
            let birthDate = formatter.date(from: birthDateString),
            let sex = Sex(rawValue: sexSC.selectedSegmentIndex)?.value
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
        let profile = Profile(id: 0, user: user, firstName: firstname, lastName: lastname, sex: sex, height: height, weight: weight, birthDate: birthDate)
        delegate(profile)
        self.dismiss(animated: true)
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.photoImageView.makeCircle()
            self.photoImageView.contentMode = .scaleAspectFill
            self.photoImageView.image = pickedImage
        } else {
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
}
