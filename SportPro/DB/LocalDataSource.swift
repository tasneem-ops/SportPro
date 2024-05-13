//
//  LocalDataSource.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

import CoreData
import UIKit

protocol ILocalDataSource{
    func insert(league : League)
}

class LocalDataSource : ILocalDataSource{
    
    var context : NSManagedObjectContext!
    static let localDataSource = LocalDataSource()
    
    
    private init(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        context = delegate.persistentContainer.viewContext
    }
    
    func insert(league : League){
        guard let leagueEntity = NSEntityDescription.entity(forEntityName: "LeagueDTO", in: context)else{
            return
        }
        let leagueDTO = NSManagedObject(entity: leagueEntity, insertInto: context)
        leagueDTO.setValue(league.name , forKey: "name")
        leagueDTO.setValue(league.key  , forKey: "key")
        leagueDTO.setValue(league.logoUrl, forKey: "logoUrl")
        do{
            try context.save()
            print("Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
}
