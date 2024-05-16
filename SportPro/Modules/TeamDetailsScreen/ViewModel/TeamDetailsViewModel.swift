
//
//  TeamDetailsViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 14/05/2024.
//

import Foundation


class TeamDetailsViewModel{
    
    private var teamDetails: APITeam
    var sportType : SportType = .football
    
    init(teamDetails: APITeam, sportType : SportType?) {
        self.teamDetails = teamDetails
        self.sportType = sportType ?? .football
    }
    
    func getTeamDetails()->APITeam{
        return teamDetails
    }
    
    func getPlayersCount() ->Int{
        return teamDetails.players?.count ?? 0
    }
}
