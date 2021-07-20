//
//  ViewController.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 17.04.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fullNameLabel.text = "\(UserDefaultsPersistance.shared.name ?? "") \(UserDefaultsPersistance.shared.secondName ?? "")"
    }

    @IBAction func saveButton(_ sender: Any) {
        UserDefaultsPersistance.shared.name = nameTextField.text
        UserDefaultsPersistance.shared.secondName = secondNameTextField.text
        fullNameLabel.text = "\(UserDefaultsPersistance.shared.name ?? "") \(UserDefaultsPersistance.shared.secondName ?? "")"
        nameTextField.text?.removeAll()
        secondNameTextField.text?.removeAll()
    }
    
}

