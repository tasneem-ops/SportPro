//
//  PastEventCollectionViewCell.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 13/05/2024.
//

import UIKit

class PastEventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventResultText: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var noPastEventsLabel: UILabel!
    
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
        homeTeamImage.clipsToBounds = true
        homeTeamImage.layer.cornerRadius = 10
        awayTeamImage.clipsToBounds = true
        awayTeamImage.layer.cornerRadius = 10
    }
}
