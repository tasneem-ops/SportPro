//
//  CustomTableViewCell.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var sportImage: UIImageView!
    
    
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOpacity = 0.3
           layer.shadowOffset = CGSize(width: 0, height: 2)
           layer.shadowRadius = 4
           layer.masksToBounds = false

           backgroundColor = UIColor.white
           layer.cornerRadius = 10
           clipsToBounds = false
           
           sportImage.contentMode = .scaleAspectFill
           sportImage.clipsToBounds = true
           sportImage.layer.cornerRadius = 10
       }
    
}
