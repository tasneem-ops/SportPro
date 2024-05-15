//
//  ViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    

    @IBOutlet weak var tableView: UITableView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
//        var remoteDataSource : RemoteDataSource<APIResultFootballLeagues>
//        remoteDataSource = RemoteDataSource()
//        // Do any additional setup after loading the view.
//        LocalDataSource.localDataSource.insert(league: League(name: "Hala", key: 123, logoUrl: "gd"))
//        remoteDataSource.fetchData(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=34e5babdbca7fd35bfc77f1203fcf99808885b0babef7cc966572dc08ae95c2b", complitionHandler: {
//            data in
//           
//        })
//        LocalDataSource.localDataSource.getAllLeagues { leagues in
//            print(leagues.count)
//        }
//        LocalDataSource.localDataSource.deleteLeague(league: League(name: "Hala", key: 123, logoUrl: "gd"))
     }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
           
        // Configure the cell with data
        //cell.name.text = "Walaa Shaaban" // Example
        
        return cell
    }
}

