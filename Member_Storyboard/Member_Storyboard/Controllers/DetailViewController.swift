//
//  DetailViewController.swift
//  Member_Storyboard
//
//  Created by 김태완 on 11/13/24.
//

import UIKit
import PhotosUI

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var memberIdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    
    var member: Member?
    weak var delegate: MemberDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberIdTextField.delegate = self
        
        if let member = member {
            mainImageView.image = member.mainImage
            memberIdTextField.text = "\(member.memberIndex)"
            nameTextField.text = member.name
            phoneNumberTextField.text = member.phone
            addressTextField.text = member.address
            ageTextField.text = member.age != nil ? "\(member.age!)" : ""
            saveButton.setTitle("UPDATE", for: .normal)
            
        } else {
            saveButton.setTitle("SAVE", for: .normal)
            memberIdTextField.text = "\(Member.memberNumbers)"
        }
        
        setupButtonAction()
        setupTapGestures()
        setupNotification()
    }
    
    func setupButtonAction() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Image touch
    func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        mainImageView.addGestureRecognizer(tapGesture)
        mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func touchUpImageView() {
        print("이미지뷰 터치")
        setupImagePicker()
    }
    
    func setupImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .videos])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    //MARK: - Notification
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func moveUpAction() {
        stackViewTopConstraint.constant = -20
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func moveDownAction() {
        stackViewTopConstraint.constant = 10
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func saveButtonTapped() {
        
        if member == nil {
            
            let name = nameTextField.text ?? ""
            let age = Int(ageTextField.text ?? "")
            let phoneNumber = phoneNumberTextField.text ?? ""
            let address = addressTextField.text ?? ""
            
            var newMember =
            Member(name: name, age: age, phone: phoneNumber, address: address)
            
            newMember.mainImage = mainImageView.image
            
            delegate?.addNewMember(newMember)
        } else {
            member!.mainImage = mainImageView.image
            
            let memberId = Int(memberIdTextField.text!) ?? 0
            member!.name = nameTextField.text ?? ""
            member!.age = Int(ageTextField.text ?? "") ?? 0
            member!.phone = phoneNumberTextField.text ?? ""
            member!.address = addressTextField.text ?? ""
            
            delegate?.update(index: memberId, member!)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension DetailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == memberIdTextField {
            return false
        }
        return true
    }
}

extension DetailViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async { self.mainImageView.image = image as? UIImage }
            }
        } else {
            print("이미지 못 불러왔음!!!!")
        }
    }
}
