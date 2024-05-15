//
//  LeagueEventtennis.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 15/05/2024.
//

import Foundation

struct LeagueEventTennis: Codable {

  var eventKey              : Int?      = nil
  var eventDate             : String?   = nil
  var eventTime             : String?   = nil
  var eventFirstPlayer      : String?   = nil
  var firstPlayerKey        : Int?      = nil
  var eventSecondPlayer     : String?   = nil
  var secondPlayerKey       : Int?      = nil
  var eventFinalResult      : String?   = nil
  var eventFirstPlayerLogo  : String?   = nil
  var eventSecondPlayerLogo : String?   = nil
    var leagueName            : String?   = nil
      var leagueKey             : Int?      = nil

  enum CodingKeys: String, CodingKey {

    case eventKey              = "event_key"
    case eventDate             = "event_date"
    case eventTime             = "event_time"
    case eventFirstPlayer      = "event_first_player"
    case firstPlayerKey        = "first_player_key"
    case eventSecondPlayer     = "event_second_player"
    case secondPlayerKey       = "second_player_key"
    case eventFinalResult      = "event_final_result"
    case eventFirstPlayerLogo  = "event_first_player_logo"
    case eventSecondPlayerLogo = "event_second_player_logo"
      case leagueName            = "league_name"
          case leagueKey             = "league_key"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    eventKey              = try values.decodeIfPresent(Int.self      , forKey: .eventKey              )
    eventDate             = try values.decodeIfPresent(String.self   , forKey: .eventDate             )
    eventTime             = try values.decodeIfPresent(String.self   , forKey: .eventTime             )
    eventFirstPlayer      = try values.decodeIfPresent(String.self   , forKey: .eventFirstPlayer      )
    firstPlayerKey        = try values.decodeIfPresent(Int.self      , forKey: .firstPlayerKey        )
    eventSecondPlayer     = try values.decodeIfPresent(String.self   , forKey: .eventSecondPlayer     )
    secondPlayerKey       = try values.decodeIfPresent(Int.self      , forKey: .secondPlayerKey       )
    eventFinalResult      = try values.decodeIfPresent(String.self   , forKey: .eventFinalResult      )
    eventFirstPlayerLogo  = try values.decodeIfPresent(String.self   , forKey: .eventFirstPlayerLogo  )
    eventSecondPlayerLogo = try values.decodeIfPresent(String.self   , forKey: .eventSecondPlayerLogo )
      leagueName            = try values.decodeIfPresent(String.self   , forKey: .leagueName            )
          leagueKey             = try values.decodeIfPresent(Int.self      , forKey: .leagueKey             )
  }

  init() {

  }

}
