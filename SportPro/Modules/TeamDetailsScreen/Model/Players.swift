//
//  Players.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import Foundation
class Players: Codable {
 
  var playerKey                : Int?    = nil
  var playerImage              : String? = nil
  var playerName               : String? = nil
  var playerNumber             : String? = nil
  var playerCountry            : String? = nil
 
 
  enum CodingKeys: String, CodingKey {
 
    case playerKey                = "player_key"
    case playerImage              = "player_image"
    case playerName               = "player_name"
    case playerNumber             = "player_number"
    case playerCountry            = "player_country"
  }
 
    required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
 
    playerKey                = try values.decodeIfPresent(Int.self    , forKey: .playerKey                )
    playerImage              = try values.decodeIfPresent(String.self , forKey: .playerImage              )
    playerName               = try values.decodeIfPresent(String.self , forKey: .playerName               )
    playerNumber             = try values.decodeIfPresent(String.self , forKey: .playerNumber             )
    playerCountry            = try values.decodeIfPresent(String.self , forKey: .playerCountry            )
  }
 
  init() {
 
  }
 
}
