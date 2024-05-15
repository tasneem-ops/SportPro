//
//  FavoriteLeaguesTableViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

import UIKit

class FavoriteLeaguesTableViewController: UIViewController, Communicator , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataImage: UIImageView!
    var viewModel : FavoriteLeaguesViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.noDataImage.isHidden = true
        self.tableView.isHidden = false
        viewModel = FavoriteLeaguesViewModel(localDataSource: LocalDataSource.localDataSource)
        updateList()
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getLeaguesCount() ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorite Leagues"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.sportImage.contentMode = .scaleAspectFit
        let league = viewModel?.getLeague(atIndex: indexPath.row)
        cell.sportImage.setCustomImage(url: URL(string: league?.logoUrl ?? ""), placeholder: "sports")
        cell.name.text = league?.name
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(row: indexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Reachability.isConnectedToNetwork(){
                    if let leagueDetailsViewController = self.storyboard?.instantiateViewController(identifier: "leagueDetails") as? LeagueDetailsViewController{
                        guard let league = viewModel?.getLeague(atIndex: indexPath.row) else { return  }
                        let viewModel = LeagueDetailsViewModel(remoteDataSource: RemoteDataSource<APIResultLeagueEvents>(), localDataSource: LocalDataSource.localDataSource, sportType: .football, league: league)
                        leagueDetailsViewController.viewModel = viewModel
                        leagueDetailsViewController.communicator = self
                        self.present(leagueDetailsViewController, animated: true)
                    }}
                else{
                    self.showNetworkAlert()
        }
    }
    
    func showAlert(row : Int){
        let alert = UIAlertController(title: "Delete League", message: "Are you sure you want to delete league from favorite?", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: {_ in
            self.viewModel?.deleteLeague(atIndex: row)
            self.updateList()
        }
        )
        let action2 = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
        alert.addAction(action)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }
    func updateList() {
        viewModel?.getAllLeagues{
            if(self.viewModel?.getLeaguesCount() == 0){
                self.noDataImage.isHidden = false
                self.tableView.isHidden = true
            }
            else{
                self.noDataImage.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    func showNetworkAlert (){
        let alert = UIAlertController(title: "Network Alert", message: "No Network available, plese check your networ connection", preferredStyle: UIAlertController.Style.alert)

        let action2 = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }
}
