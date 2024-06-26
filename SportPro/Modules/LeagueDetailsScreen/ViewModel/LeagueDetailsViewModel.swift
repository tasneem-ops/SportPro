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
    
    var isNoUpcomingEvents : Bool = false
    var isNoPastEvents : Bool = false
    var isNoTeams : Bool = false
    init(remoteDataSource: any IRemoteDataSource<APIResultLeagueEvents>, localDataSource: ILocalDataSource, sportType: SportType,league:League) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.sportType = sportType
        self.league = league
    }
    private var upcomingEvents:[LeagueEvent] = []
    private var pastEvents:[LeagueEvent] = []
    func getUpcomingEvents(complitionHandler: @escaping () -> Void){
        let currentDate = getTomorrow()
        let nextYear = getNextYear()
        let subquery =  String(league.key) + "&from=" + currentDate
        let query = subquery + "&to=" + nextYear + "&APIkey=" + apiKey
        let url = baseUrl + sportType.rawValue + "?met=Fixtures&leagueId=" + query
        switch sportType {
        case .tennis:
            RemoteDataSource<APIResultLeagueEventTennis>().fetchData(url: url){
                events, error in
                if(error != nil){
                    self.isNoUpcomingEvents = true
                }
                else{
                    if(events?.result?.count == 0){
                        self.isNoUpcomingEvents = true
                    }
                    var myevents : [LeagueEvent] = []
                    if let tennisEvents  = events?.result{
                        myevents = self.mapTennisToEvent(tennisEvents: tennisEvents)
                    }
                    self.upcomingEvents = myevents
                }
                complitionHandler()
            }
        default:
            remoteDataSource.fetchData(url: url){
                events, error in
                if(error != nil){
                    self.isNoUpcomingEvents = true
                }
                else{
                    if(events?.result?.count == 0){
                        self.isNoUpcomingEvents = true
                    }
                    self.upcomingEvents = events?.result ?? []
                }
                complitionHandler()
            }
        }
    }
    
    func getPastEvents(complitionHandler: @escaping () -> Void){
        let currentDate = getYesterday()
        let lastYear = getLastYear()
        let subquery =  String(league.key) + "&from=" + lastYear
        let query = subquery + "&to=" + currentDate + "&APIkey=" + apiKey
        let url = baseUrl + sportType.rawValue + "?met=Fixtures&leagueId=" + query
        switch(sportType){
        case .tennis:
            RemoteDataSource<APIResultLeagueEventTennis>().fetchData(url: url){
                events, error in
                if(error != nil){
                    self.isNoPastEvents = true
                }
                else{
                    if(events?.result?.count == 0){
                        self.isNoPastEvents = true
                    }
                    var myevents : [LeagueEvent] = []
                    if let tennisEvents  = events?.result{
                        myevents = self.mapTennisToEvent(tennisEvents: tennisEvents)
                    }
                    self.pastEvents = myevents
                }
                complitionHandler()
            }
        default:
            remoteDataSource.fetchData(url: url){
                events, error in
                if(error != nil){
                    self.isNoPastEvents = true
                }
                else{
                    if(events?.result?.count == 0){
                        self.isNoPastEvents = true
                    }
                    self.pastEvents = events?.result ?? []
                }
                complitionHandler()
            }
        }
        
    }
    
    func deleteLeague(){
        localDataSource.deleteLeague(league: self.league)
    }
    
    func insertLeague(){
        localDataSource.insert(league: self.league)
    }
    func getTeams(complitionHandler: @escaping () -> Void){
        let query = String(league.key) + "&APIkey=" + apiKey
        let url = baseUrl + sportType.rawValue + "?met=Teams&leagueId=" + query
        let remote = RemoteDataSource<APIResultTeams>()
        remote.fetchData(url: url){
            teams, error in
            if(error != nil){
                self.isNoTeams = true
            }
            else{
                if(teams?.result?.count == 0){
                    self.isNoTeams = true
                }
                self.teams = teams?.result ?? []
            }
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
    private func mapTennisToEvent(tennisEvents : [LeagueEventTennis]) -> [LeagueEvent]{
        var myevents : [LeagueEvent] = []
        for t in tennisEvents{
            var event = LeagueEvent()
            event.awayTeamLogo = t.eventSecondPlayerLogo
            event.eventAwayTeam = t.eventSecondPlayer
            event.eventHomeTeam = t.eventFirstPlayer
            event.homeTeamLogo = t.eventFirstPlayerLogo
            event.leagueName = t.leagueName
            event.leagueKey = t.leagueKey
            event.eventFinalResult = t.eventFinalResult
            event.eventDate = t.eventDate
            event.eventTime = t.eventTime
            event.eventKey = t.eventKey
            myevents.append(event)
        }
        return myevents
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
    private func getTomorrow()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date.tomorrow)
        return currentDate
    }
    private func getYesterday() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date.yesterday)
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

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}
