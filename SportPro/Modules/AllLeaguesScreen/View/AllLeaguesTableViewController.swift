//
//  AllLeaguesTableViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 12/05/2024.
//

import UIKit
import Kingfisher

class AllLeaguesTableViewController: UITableViewController {

    var viewModel : AllLeaguesViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let league = viewModel?.getLeague(atIndex: indexPath.row)
        let url = URL(string: (league?.leagueLogo ?? league?.countryLogo) ?? "")
        let processor = DownsamplingImageProcessor(size: cell.sportImage.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.sportImage.kf.indicatorType = .activity
        cell.sportImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "sports"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        cell.name.text = league?.leagueName
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let leagueDetailsViewController = self.storyboard?.instantiateViewController(identifier: "leagueDetails") as? LeagueDetailsViewController{
            let sportLeague = viewModel?.getLeague(atIndex: indexPath.row)
            let league = League(name: sportLeague?.leagueName ?? "", key: Int16(sportLeague?.leagueKey ?? 0), logoUrl: sportLeague?.leagueLogo ?? "")
            let viewModel = LeagueDetailsViewModel(remoteDataSource: RemoteDataSource<APIResultLeagueEvents>(), localDataSource: LocalDataSource.localDataSource, sportType: viewModel?.sportType ?? .football, league: league)
            leagueDetailsViewController.viewModel = viewModel
            self.present(leagueDetailsViewController, animated: true)
        }
        
    }

}
