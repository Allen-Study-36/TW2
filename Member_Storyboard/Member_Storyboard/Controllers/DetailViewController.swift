//
//  DetailViewController.swift
//  Member_Storyboard
//
//  Created by 김태완 on 11/13/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var memberIdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var member: Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let member = member else {
            saveButton.setTitle("SAVE", for: .normal)
            memberIdTextField.text = "\(Member.memberNumbers)"
            return
        }
        
        mainImageView.image = member.mainImage
        memberIdTextField.text = "\(member.memberIndex)"
        nameTextField.text = member.name
        phoneNumberTextField.text = member.phone
        addressTextField.text = member.address
        ageTextField.text = member.age != nil ? "\(member.age!)" : ""
        
    }
    
}
