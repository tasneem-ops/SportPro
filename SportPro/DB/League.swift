//
//  League.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

class League{
    var name : String
    var key: Int16
    var logoUrl : String
    init(name: String, key: Int16, logoUrl: String) {
        self.name = name
        self.key = key
        self.logoUrl = logoUrl
    }
}
