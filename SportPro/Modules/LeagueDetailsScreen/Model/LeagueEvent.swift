//
//  LeagueEvent.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import Foundation

class LeagueEvent: Codable {
 
  var eventKey            : Int?           = nil
  var eventDate           : String?        = nil
  var eventTime           : String?        = nil
  var eventHomeTeam       : String?        = nil
  var homeTeamKey         : Int?           = nil
  var eventAwayTeam       : String?        = nil
  var awayTeamKey         : Int?           = nil
  var eventFinalResult    : String?        = nil
  var leagueName          : String?        = nil
  var leagueKey           : Int?           = nil
  var homeTeamLogo        : String?        = nil
  var awayTeamLogo        : String?        = nil
  var leagueLogo          : String?        = nil
 
  enum CodingKeys: String, CodingKey {
 
    case eventKey            = "event_key"
    case eventDate           = "event_date"
    case eventTime           = "event_time"
    case eventHomeTeam       = "event_home_team"
    case homeTeamKey         = "home_team_key"
    case eventAwayTeam       = "event_away_team"
    case awayTeamKey         = "away_team_key"
    case eventFinalResult    = "event_final_result"
    case leagueName          = "league_name"
    case leagueKey           = "league_key"
    case homeTeamLogo        = "home_team_logo"
    case awayTeamLogo        = "away_team_logo"
    case leagueLogo          = "league_logo"
  
  }
 
    required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
 
    eventKey            = try values.decodeIfPresent(Int.self           , forKey: .eventKey            )
    eventDate           = try values.decodeIfPresent(String.self        , forKey: .eventDate           )
    eventTime           = try values.decodeIfPresent(String.self        , forKey: .eventTime           )
    eventHomeTeam       = try values.decodeIfPresent(String.self        , forKey: .eventHomeTeam       )
    homeTeamKey         = try values.decodeIfPresent(Int.self           , forKey: .homeTeamKey         )
    eventAwayTeam       = try values.decodeIfPresent(String.self        , forKey: .eventAwayTeam       )
    awayTeamKey         = try values.decodeIfPresent(Int.self           , forKey: .awayTeamKey         )
    eventFinalResult    = try values.decodeIfPresent(String.self        , forKey: .eventFinalResult    )
    leagueName          = try values.decodeIfPresent(String.self        , forKey: .leagueName          )
    leagueKey           = try values.decodeIfPresent(Int.self           , forKey: .leagueKey           )
    homeTeamLogo        = try values.decodeIfPresent(String.self        , forKey: .homeTeamLogo        )
    awayTeamLogo        = try values.decodeIfPresent(String.self        , forKey: .awayTeamLogo        )
    leagueLogo          = try values.decodeIfPresent(String.self        , forKey: .leagueLogo          )
  }
 
  init() {
 
  }
 
}
