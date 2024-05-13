//
//  FavoriteLeaguesViewModel.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

import Foundation
class FavoriteLeaguesViewModel{
    var localDataSource : ILocalDataSource
    private var leagueList : [League] = []
    
    init(localDataSource: ILocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func getAllLeagues(complitionHandler: @escaping () -> Void){
        localDataSource.getAllLeagues{
            leagues in
            self.leagueList = leagues
            complitionHandler()
        }
        
    }
    
    func deleteLeague(atIndex : Int){
        localDataSource.deleteLeague(league: leagueList[atIndex])
    }
    
    func getLeague(atIndex: Int) -> League{
        return leagueList[atIndex]
    }
    func getLeaguesCount() -> Int{
        return leagueList.count
    }
}
