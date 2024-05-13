//
//  AllLeaguesViewModel.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

class AllLeaguesViewModel {
    var remoteDataSource :  any IRemoteDataSource<APIResultSportLeagues>
    var sportType : SportType
    let baseUrl = "https://apiv2.allsportsapi.com/"
    let apiKey = "34e5babdbca7fd35bfc77f1203fcf99808885b0babef7cc966572dc08ae95c2b"
   
    private var leagueList : [SportLeagues] = []
    
    init(remoteDataSource: any IRemoteDataSource<APIResultSportLeagues>, sportType: SportType) {
        self.remoteDataSource = remoteDataSource
        self.sportType = sportType
    }
    
    func getAllLeagues(complitionHandler: @escaping () -> Void){
        let url = baseUrl + sportType.rawValue + "/?met=Leagues&APIkey=" + apiKey
        
        remoteDataSource.fetchData(url: url){
            response in
            self.leagueList = response?.result ?? []
            complitionHandler()
        }
    }
    
    func getLeague(atIndex: Int) -> SportLeagues{
        return leagueList[atIndex]
    }
    func getLeaguesCount() -> Int{
        return leagueList.count
    }
}
