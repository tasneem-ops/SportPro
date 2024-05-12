//
//  AllLeaguesTableViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

import UIKit

class AllLeaguesTableViewController: UITableViewController {

    var viewModel : AllLeaguesViewModel?
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
        return viewModel?.getLeaguesCount() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Don't Forget To Cast it to the nib cell class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let league = viewModel?.getLeague(atIndex: indexPath.row)
        // cell.myimage.image = league.logo ?? league.countrylogo ?? "static image"
        //cell.label.text = league.leagueName
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Present the other viewcontroller league details without
        //Write this in viewDidLoad of LeagueDetailsScreen
        //self.modalPresentationStyle = .fullScreen
        guard let leagueDetailsViewController = self.storyboard?.instantiateViewController(identifier: "leagueDetails") else { return }
        self.present(leagueDetailsViewController, animated: true)
    }

}
