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
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var noPlayersLabel: UILabel!
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
        teamImage.setCustomImage(url: URL(string: viewModel.getTeamDetails().teamLogo ?? ""), placeholder: "team")
    }
    override func viewWillAppear(_ animated: Bool) {
        if(viewModel?.getPlayersCount() == 0){
            noPlayersLabel.isHidden = false
            collectionView.isHidden = true
        }
        else{
            noPlayersLabel.isHidden = true
            collectionView.isHidden = false
        }
        switch viewModel?.sportType {
        case .football:
            sportImage.image = UIImage(named: "football")
        case .basketball:
            sportImage.image = UIImage(named: "basketball")
        case .cricket:
            sportImage.image = UIImage(named: "cricket")
        case .tennis:
            sportImage.image = UIImage(named: "tennis")
        case nil:
            sportImage.image = UIImage(named: "noData")
        }
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


