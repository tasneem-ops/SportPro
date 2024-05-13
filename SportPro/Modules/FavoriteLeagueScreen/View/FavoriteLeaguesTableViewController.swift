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
        //Will Destroy if you don't fix the name!!!
        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.getAllLeagues{
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Don't Forget To Cast it to the nib cell class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let league = viewModel?.getLeague(atIndex: indexPath.row)
        // cell.myimage.image = league.logo ?? league.countrylogo ?? "static image"
        //cell.label.text = league.leagueName
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(row: indexPath.row)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Present the other viewcontroller league details without
        //Write this in viewDidLoad of LeagueDetailsScreen
        //self.modalPresentationStyle = .fullScreen
        guard let leagueDetailsViewController = self.storyboard?.instantiateViewController(identifier: "leagueDetails") else { return }
        self.present(leagueDetailsViewController, animated: true)
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
