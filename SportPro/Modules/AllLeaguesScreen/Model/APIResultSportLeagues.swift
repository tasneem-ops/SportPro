//
//  APIResultSportLeagues.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

class APIResultSportLeagues: Codable {

  var success : Int?      = nil
  var result  : [SportLeagues]? = []

  enum CodingKeys: String, CodingKey {

    case success = "success"
    case result  = "result"
  
  }

    required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    success = try values.decodeIfPresent(Int.self      , forKey: .success )
    result  = try values.decodeIfPresent([SportLeagues].self , forKey: .result  )
 
  }

  init() {

  }

}
