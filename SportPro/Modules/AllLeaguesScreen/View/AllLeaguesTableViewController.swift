//
//  AllLeaguesTableViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

import UIKit
import Kingfisher

class AllLeaguesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel : AllLeaguesViewModel?
    let indicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
    }
    override func viewWillAppear(_ animated: Bool) {
        indicator.center = self.view.center
        indicator.startAnimating()
        self.view.addSubview(indicator)
        tableView.isHidden = false
        errorImage.isHidden = true
        viewModel?.getAllLeagues{
            self.indicator.stopAnimating()
            if(self.viewModel?.isError == true){
                self.errorImage.isHidden = false
                self.tableView.isHidden = true
            }
            else{
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getLeaguesCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.sportImage.contentMode = .scaleAspectFit
        let league = viewModel?.getLeague(atIndex: indexPath.row)
        let url = URL(string: (league?.leagueLogo ?? league?.countryLogo) ?? "")
        cell.sportImage.setCustomImage(url: url, placeholder: viewModel?.sportType.rawValue ?? "sports")
        cell.name.text = league?.leagueName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(Reachability.isConnectedToNetwork()){
                    if let leagueDetailsViewController = self.storyboard?.instantiateViewController(identifier: "leagueDetails") as? LeagueDetailsViewController{
                        let sportLeague = viewModel?.getLeague(atIndex: indexPath.row)
                        let league = League(name: sportLeague?.leagueName ?? "", key: Int16(sportLeague?.leagueKey ?? 0), logoUrl: sportLeague?.leagueLogo ?? "")
                        let viewModel = LeagueDetailsViewModel(remoteDataSource: RemoteDataSource<APIResultLeagueEvents>(), localDataSource: LocalDataSource.localDataSource, sportType: viewModel?.sportType ?? .football, league: league)
                        leagueDetailsViewController.viewModel = viewModel
                        self.present(leagueDetailsViewController, animated: true)
                    }
                }
                else{
                    self.showNetworkAlert()
                }
    }
    func showNetworkAlert(){
            let alert = UIAlertController(title: "Network Alert", message: "No Network available, plese check your networ connection", preferredStyle: UIAlertController.Style.alert)

            let action2 = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
            alert.addAction(action2)
            self.present(alert, animated: true)
        }
}
