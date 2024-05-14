//
//  FakeRemoteDataSource.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 14/05/2024.
//

import Foundation


class MockNetworkService: IRemoteDataSource{
    
    typealias T = APIResultSportLeagues
    
    var shouldReturnError : Bool!
    init(shouldReturnError: Bool!) {
        self.shouldReturnError = shouldReturnError
    }
    enum responseError : Error{
        case error
    }
    let fakeJson  = """
    {"success":1,"result":[{"league_key":733,"league_name":"4-Day Franchise Series","league_year":"2022-23"},{"league_key":8301,"league_name":"Abu Dhabi T10","league_year":"2023-24"},{"league_key":9874,"league_name":"ACC Men's Emerging Cup","league_year":"2023"},{"league_key":9453,"league_name":"ACC Men's Premier Cup","league_year":"2024"},{"league_key":10321,"league_name":"Afghanistan A tour of Oman","league_year":"2023-24"},{"league_key":10942,"league_name":"Afghanistan A tour of Sri Lanka","league_year":"2024"},{"league_key":742,"league_name":"Afghanistan tour of Bangladesh","league_year":"2023"}]}
    """.data(using: .utf8)
    func fetchData(url: String, complitionHandler: @escaping (APIResultSportLeagues?, Error?) -> Void) {
        if(shouldReturnError){
            complitionHandler(nil, responseError.error)
        }
        else{
            var result = APIResultSportLeagues()
            do{
                guard let json = fakeJson else{return}
                result = try JSONDecoder().decode(APIResultSportLeagues.self, from: json)
                complitionHandler(result, nil)
            }catch let error{
                complitionHandler(nil , error)
            }
        }
    }
}
