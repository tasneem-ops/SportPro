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
    func deleteLeague(league:League)
    func getAllLeagues(complitionHandler: @escaping ([League]) -> Void)
    func isFavourite(league: League, complitionHandler: @escaping (Bool) -> Void)
}

class LocalDataSource : ILocalDataSource{
    
    var context : NSManagedObjectContext!
    static let localDataSource = LocalDataSource()
    
    
    private init(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        context = delegate.persistentContainer.viewContext
    }
    
    func isFavourite(league: League, complitionHandler: @escaping (Bool) -> Void) {
        
//        guard NSEntityDescription.entity(forEntityName: "LeagueDTO", in: context) != nil else {
//            return
//        }
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LeagueDTO")
            fetchRequest.predicate = NSPredicate(format: "key == %ld", league.key)
        
        
        do {
                let leagues = try context.fetch(fetchRequest)

                if let leagueDTO = leagues.first as? NSManagedObject {
                   complitionHandler(true)
                } else {
                    complitionHandler(false)
                }
            } catch {
                print("Error fetching league for deletion: \(error.localizedDescription)")
            }
        
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
    
    func deleteLeague(league: League) {
        
        guard NSEntityDescription.entity(forEntityName: "LeagueDTO", in: context) != nil else {
            return
        }
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LeagueDTO")
            fetchRequest.predicate = NSPredicate(format: "key == %ld", league.key)
        
        do {
                let leagues = try context.fetch(fetchRequest)

                if let leagueDTO = leagues.first as? NSManagedObject {
                    context.delete(leagueDTO)

                    do {
                        try context.save()
                        print("League Deleted: \(league.name)")
                    } catch {
                        print("Error saving context after deleting league: \(error.localizedDescription)")
                    }
                } else {
                    print("League not found for deletion.")
                }
            } catch {
                print("Error fetching league for deletion: \(error.localizedDescription)")
            }
    }

 

 
    func getAllLeagues(complitionHandler: @escaping ([League]) -> Void) {
        var leagues: [League] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueDTO")
       
        do{
            let leagueDTOs = try context.fetch(fetchRequest)
                    
                    for leagueDTO in leagueDTOs {
                        let league = League(name: leagueDTO.value(forKey: "name") as! String,
                                            key: leagueDTO.value(forKey: "key") as! Int16,
                                            logoUrl: leagueDTO.value(forKey: "logoUrl") as! String)
                        
                        print(league.name)
                        
                        leagues.append(league)
                    }
            complitionHandler(leagues)
            
        }catch let error{
            print("error \(error)")
        }
           
        //return leagues
    }
}
