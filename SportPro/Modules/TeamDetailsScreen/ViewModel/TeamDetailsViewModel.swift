
//
//  TeamDetailsViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 14/05/2024.
//

import Foundation


class TeamDetailsViewModel{
    
    private var teamDetails: APITeam
    
    init(teamDetails: APITeam) {
        self.teamDetails = teamDetails
    }
    
    func getTeamDetails()->APITeam{
        return teamDetails
    }
    
    func getPlayersCount() ->Int{
        return teamDetails.players?.count ?? 0
    }
}
