//
//  MemberTableViewCell.swift
//  Member_Storyboard
//
//  Created by 김태완 on 11/12/24.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    
    var member: Member? {
        didSet {
            guard let member else { return }
            mainImageView.image = member.mainImage
            nameLabel.text = member.name
            addressLabel.text = member.address
        }
    }
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
