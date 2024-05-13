//
//  LeagueDetailsViewModel.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import Foundation

class LeagueDetailsViewModel{
    var remoteDataSource :  any IRemoteDataSource<APIResultLeagueEvents>
    var localDataSource : ILocalDataSource
    var sportType : SportType
    var league:League
    var teams : [APITeam] = []
    var isFav:Bool!
    let baseUrl = "https://apiv2.allsportsapi.com/"
    let apiKey = "34e5babdbca7fd35bfc77f1203fcf99808885b0babef7cc966572dc08ae95c2b"
    init(remoteDataSource: any IRemoteDataSource<APIResultLeagueEvents>, localDataSource: ILocalDataSource, sportType: SportType,league:League) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.sportType = sportType
        self.league = league
    }
    private var upcomingEvents:[LeagueEvent] = []
    private var pastEvents:[LeagueEvent] = []
    func getUpcomingEvents(complitionHandler: @escaping () -> Void){
        let currentDate = getCurrentDate()
        let nextYear = getNextYear()
        let subquery =  String(league.key) + "&from=" + currentDate
        let query = subquery + "&to=" + nextYear + "&APIkey=" + apiKey
        let url = baseUrl + sportType.rawValue + "?met=Fixtures&leagueId=" + query
        remoteDataSource.fetchData(url: url){
            events in
            print(events?.result?.count)
            self.upcomingEvents = events?.result ?? []
            complitionHandler()
        }
    }
    
    func getPastEvents(complitionHandler: @escaping () -> Void){
        let currentDate = getCurrentDate()
        let lastYear = getLastYear()
        let subquery =  String(league.key) + "&from=" + lastYear
        let query = subquery + "&to=" + currentDate + "&APIkey=" + apiKey
        let url = baseUrl + sportType.rawValue + "?met=Fixtures&leagueId=" + query
        remoteDataSource.fetchData(url: url){
            events in
            print(events?.result?.count)
            self.pastEvents = events?.result ?? []
            complitionHandler()
        }
    }
    
    func deleteLeague(){
        localDataSource.deleteLeague(league: self.league)
    }
    
    func insertLeague(){
        localDataSource.insert(league: self.league)
    }
    func getTeams(complitionHandler: @escaping () -> Void){
        //https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=207&APIkey=d2538bc4458303020afacfc7511cb9f5808e36e454a61508dcb8a7ade6984775
        let query = String(league.key) + "&APIkey=" + apiKey
        let url = baseUrl + sportType.rawValue + "?met=Teams&leagueId=" + query
        let remote = RemoteDataSource<APIResultTeams>()
        remote.fetchData(url: url){
            teams in
            self.teams = teams?.result ?? []
            complitionHandler()
        }
    }
    
    func getUpcomingEventsList()->[LeagueEvent]{
        return upcomingEvents
    }
    func getPastEventsList()->[LeagueEvent]{
        return pastEvents
    }
    
    func getTeamsList()->[APITeam]{
        return teams
    }
    
    func isFavourite(complitionHandler: @escaping (Bool) -> Void){
        localDataSource.isFavourite(league: league) { res in
            self.isFav = res
            complitionHandler(self.isFav)
        }
    }
//    func getTeams() ->[Team]{
//        teams = Set()
//        upcomingEvents.forEach { event in
//            let awayTeam = Team(key: event.awayTeamKey, name: event.eventAwayTeam, image: event.awayTeamLogo)
//            let homeTeam = Team(key: event.homeTeamKey, name: event.eventHomeTeam, image: event.homeTeamLogo)
//            teams.insert(awayTeam)
//            teams.insert(homeTeam)
//        }
//        return Array(teams)
//    }
    
    func getTeamCount()->Int{
        print("Count \(teams.count)")
        return teams.count
    }
    
    private func getCurrentDate() ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        return currentDate
    }
    
    private func getNextYear() ->String{
        let currentDate = Date()
        let nextYearDate = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nextYearDateString = dateFormatter.string(from: nextYearDate)
        return nextYearDateString
    }
    private func getLastYear() ->String{
        let currentDate = Date()
        let lastYearDate = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let lastYearDateString = dateFormatter.string(from: lastYearDate)
        return lastYearDateString
    }
    
    func getUpcomingEventsCount () -> Int{
        return self.upcomingEvents.count
    }
    
    func getPastEventsCount () -> Int{
        return self.pastEvents.count
    }
}
