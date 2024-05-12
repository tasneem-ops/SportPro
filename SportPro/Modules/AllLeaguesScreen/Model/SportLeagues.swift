//
//  SportLeague.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

struct SportLeagues: Codable {

    var leagueKey   : Int?    = nil
    var leagueName  : String? = nil
    var countryKey  : Int?    = nil
    var countryName : String? = nil
    var leagueLogo  : String? = nil
    var countryLogo : String? = nil

    enum CodingKeys: String, CodingKey {

      case leagueKey   = "league_key"
      case leagueName  = "league_name"
      case countryKey  = "country_key"
      case countryName = "country_name"
      case leagueLogo  = "league_logo"
      case countryLogo = "country_logo"
    
    }

    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)

      leagueKey   = try values.decodeIfPresent(Int.self    , forKey: .leagueKey   )
      leagueName  = try values.decodeIfPresent(String.self , forKey: .leagueName  )
      countryKey  = try values.decodeIfPresent(Int.self    , forKey: .countryKey  )
      countryName = try values.decodeIfPresent(String.self , forKey: .countryName )
      leagueLogo  = try values.decodeIfPresent(String.self , forKey: .leagueLogo  )
      countryLogo = try values.decodeIfPresent(String.self , forKey: .countryLogo )
   
    }

    init() {

    }


}
