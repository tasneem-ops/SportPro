//
//  APIResultLeagueEvents.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import Foundation


class APIResultLeagueEvents: Codable {
 
  var success : Int?      = nil
  var result  : [LeagueEvent]? = []
 
  enum CodingKeys: String, CodingKey {
 
    case success = "success"
    case result  = "result"
  
  }
 
    required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
 
    success = try values.decodeIfPresent(Int.self      , forKey: .success )
    result  = try values.decodeIfPresent([LeagueEvent].self , forKey: .result  )
 
  }
 
  init() {
 
  }
 
}
