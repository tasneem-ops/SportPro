//
//  HomeCollectionViewCell.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImage: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    
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
                sportImage.clipsToBounds = true
                sportImage.layer.cornerRadius = 10
        }
    
   
}
