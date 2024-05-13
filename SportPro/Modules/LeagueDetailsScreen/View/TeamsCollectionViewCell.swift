//
//  TeamsCollectionViewCell.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        backgroundColor = UIColor.white
        teamImage.clipsToBounds = true
        teamImage.layer.cornerRadius = 50
    }
}
