//
//  APIResultLeagueEventTennis.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 15/05/2024.
//

import Foundation
struct APIResultLeagueEventTennis: Codable {

  var success : Int?      = nil
  var result  : [LeagueEventTennis]? = []

  enum CodingKeys: String, CodingKey {

    case success = "success"
    case result  = "result"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    success = try values.decodeIfPresent(Int.self      , forKey: .success )
    result  = try values.decodeIfPresent([LeagueEventTennis].self , forKey: .result  )
 
  }

  init() {

  }

}
