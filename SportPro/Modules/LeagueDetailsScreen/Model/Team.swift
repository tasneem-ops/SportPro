//
//  Team.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import Foundation
class Team{
    var key:Int?
    var name:String?
    var image:String?
    
    init(key: Int?, name: String?, image: String?) {
        self.key = key
        self.name = name
        self.image = image
    }
}

extension Team: Hashable { 
    static func == (lt: Team, rt: Team) -> Bool {
        return lt.key == rt.key
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}
