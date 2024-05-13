//
//  FavoriteLeaguesTableViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

import UIKit

class FavoriteLeaguesTableViewController: UITableViewController {
    var viewModel : FavoriteLeaguesViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel = FavoriteLeaguesViewModel(localDataSource: LocalDataSource.localDataSource)
        viewModel?.getAllLeagues{
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getLeaguesCount() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let league = viewModel?.getLeague(atIndex: indexPath.row)
        cell.sportImage.setCustomImage(image: cell.sportImage, url: URL(string: league?.logoUrl ?? ""))
        cell.name.text = league?.name
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(row: indexPath.row)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let leagueDetailsViewController = self.storyboard?.instantiateViewController(identifier: "leagueDetails") as? LeagueDetailsViewController{
            guard let league = viewModel?.getLeague(atIndex: indexPath.row) else { return  }
            let viewModel = LeagueDetailsViewModel(remoteDataSource: RemoteDataSource<APIResultLeagueEvents>(), localDataSource: LocalDataSource.localDataSource, sportType: .football, league: league)
            leagueDetailsViewController.viewModel = viewModel
            self.present(leagueDetailsViewController, animated: true)
        }
    }
    
    func showAlert(row : Int){
        let alert = UIAlertController(title: "Delete League", message: "Are you sure you want to delete league from favorite?", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: {_ in
            self.viewModel?.deleteLeague(atIndex: row)
            self.tableView.reloadData()
        }
        )
        let action2 = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
        alert.addAction(action)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }

}
