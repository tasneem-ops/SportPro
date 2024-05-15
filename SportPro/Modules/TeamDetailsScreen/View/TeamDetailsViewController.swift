//
//  TeamDetailsViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 13/05/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamNAme: UILabel!
    @IBOutlet weak var errorImage: UIImageView!
    var viewModel:TeamDetailsViewModel!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPlayersCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlayerCollectionViewCell
        cell.playerImage.setCustomImage(url: URL(string: viewModel.getTeamDetails().players?[indexPath.row].playerImage ?? ""), placeholder: "player")
        cell.playerImage.makeRounded()
        cell.playerName.text = viewModel.getTeamDetails().players?[indexPath.row].playerName
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        teamImage.makeRounded()
        teamNAme.text = viewModel.getTeamDetails().teamName
        teamImage.setCustomImage(url: URL(string: viewModel.getTeamDetails().teamLogo ?? ""), placeholder: "Team Logo")
//        RemoteDataSource<APIResultTeams>().fetchData(url: "https://apiv2.allsportsapi.com/football/?met=Teams&teamId=85&APIkey=34e5babdbca7fd35bfc77f1203fcf99808885b0babef7cc966572dc08ae95c2b"){
//            response in
//            self.teamImage.setCustomImage(url: URL(string: response?.result?[0].teamLogo ?? ""), placeholder: "basketball")
//            self.teamNAme.text = response?.result?[0].teamName
//            self.players = response?.result?[0].players ?? []
//            self.collectionView.reloadData()
//        }
    }

}

extension TeamDetailsViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 150)
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
        }

        func collectionView(_ collectionView: UICollectionView, layout
            collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
        }
    }
extension UIImageView {
    
    func makeRounded() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}


