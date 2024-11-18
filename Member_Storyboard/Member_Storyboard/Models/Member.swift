//
//  Member.swift
//  Member_Storyboard
//
//  Created by 김태완 on 11/12/24.
//

import UIKit

struct Member {
    
    static var memberNumbers: Int = 0
    
    let memberIndex: Int
    var mainImage: UIImage?
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    init(name: String?, age: Int?, phone: String?, address: String?) {
        
        self.memberIndex = Member.memberNumbers
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        if let name {
            self.mainImage = UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
        } else {
            self.mainImage = UIImage(systemName: "person")
        }
        
        Member.memberNumbers += 1
    }
}
