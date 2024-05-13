//
//  HomeViewModel.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import Foundation

class HomeViewModel{
    
    private var sports:[Sport] = []
    
    init() {
        sports.append(Sport(image: "football", name: "Football"))
        sports.append(Sport(image: "tennis", name: "Tennis"))
        sports.append(Sport(image: "cricket", name: "Cricket"))
        sports.append(Sport(image: "basketball", name: "Basketball"))
    }
    
    func getSports()->[Sport]{
       
        return sports
    }
    
    
    func getCount()->Int{
        sports.count
    }
    
}
