//
//  APITeam.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import Foundation

class APITeam : Codable {
    
    var teamKey  : Int?       = nil
    var teamName : String?    = nil
    var teamLogo : String?    = nil
    var players  : [Players]? = []
    
    enum CodingKeys: String, CodingKey {
        
        case teamKey  = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players  = "players"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        teamKey  = try values.decodeIfPresent(Int.self       , forKey: .teamKey  )
        teamName = try values.decodeIfPresent(String.self    , forKey: .teamName )
        teamLogo = try values.decodeIfPresent(String.self    , forKey: .teamLogo )
        players  = try values.decodeIfPresent([Players].self , forKey: .players  )
        
    }
    
    init() {
        
    }
}
