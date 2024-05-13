//
//  LeagueDetailsViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 13/05/2024.
//

import UIKit
import Kingfisher

class LeagueDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var favButton: UIButton!
    var viewModel : LeagueDetailsViewModel?
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        let layout = UICollectionViewCompositionalLayout{ section , environment in
            switch section{
            case 0:
                return self.drawTopSection()
            case 1:
                return self.drawMiddleSection()
            default:
                return self.drawBottomSection()
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        if(viewModel == nil){
            print("NILLLLLL")
        }
        viewModel?.getPastEvents(complitionHandler: {
            print("Data Returned")
            self.collectionView.reloadData()
        })
        viewModel?.getUpcomingEvents( complitionHandler: {
            print("Data Returned")
            self.collectionView.reloadData()
        })
        viewModel?.getTeams(complitionHandler: {
            print("Data Returned")
            self.collectionView.reloadData()
        })
        viewModel?.isFavourite(complitionHandler: { isFav in
            if isFav{
                self.favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        })
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return 4
        switch section{
        case 0:
            return viewModel?.getUpcomingEventsCount() ?? 1
        case 1:
            return viewModel?.getPastEventsCount() ?? 1
        default:
            return viewModel?.getTeamCount() ?? 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEvent", for: indexPath) as! UpcomingEventCollectionViewCell
            cell.homeTeamName.text = viewModel?.getUpcomingEventsList()[indexPath.row].eventHomeTeam
            cell.awayTeamName.text = viewModel?.getUpcomingEventsList()[indexPath.row].eventAwayTeam
            cell.leagueNameLabel.text = viewModel?.getUpcomingEventsList()[indexPath.row].leagueName
            cell.eventTimeLabel.text = viewModel?.getUpcomingEventsList()[indexPath.row].eventTime
            cell.eventDateLabel.text = viewModel?.getUpcomingEventsList()[indexPath.row].eventDate
            cell.awayTeamImage.setCustomImage(image: cell.awayTeamImage, url: URL(string: viewModel?.getUpcomingEventsList()[indexPath.row].awayTeamLogo ?? ""))
            cell.homeTeamImage.setCustomImage(image: cell.homeTeamImage, url: URL(string: viewModel?.getUpcomingEventsList()[indexPath.row].homeTeamLogo ?? ""))
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pastEvent", for: indexPath) as! PastEventCollectionViewCell
            cell.homeTeamName.text = viewModel?.getPastEventsList()[indexPath.row].eventHomeTeam
            cell.awayTeamName.text = viewModel?.getPastEventsList()[indexPath.row].eventAwayTeam
            cell.eventResultText.text = viewModel?.getPastEventsList()[indexPath.row].eventFinalResult
            cell.awayTeamImage.setCustomImage(image: cell.awayTeamImage,  url: URL(string: viewModel?.getPastEventsList()[indexPath.row].awayTeamLogo ?? ""))
            cell.homeTeamImage.setCustomImage(image: cell.homeTeamImage,  url: URL(string: viewModel?.getPastEventsList()[indexPath.row].homeTeamLogo ?? ""))
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teams", for: indexPath) as! TeamsCollectionViewCell
            cell.teamName.text = viewModel?.getTeamsList()[indexPath.row].teamName
            cell.teamImage.setCustomImage(image: cell.teamImage,  url: URL(string: viewModel?.getTeamsList()[indexPath.row].teamLogo ?? ""))
            return cell
        }
    }
    func drawTopSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 16, bottom: 16, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
             items.forEach { item in
             let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
             let minScale: CGFloat = 0.8
             let maxScale: CGFloat = 1.0
             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
             item.transform = CGAffineTransform(scaleX: scale, y: scale)
             }
        }
        
        return section
        
    }
    func drawMiddleSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 8, bottom: 16, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
             items.forEach { item in
             let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
             let minScale: CGFloat = 0.8
             let maxScale: CGFloat = 1.0
             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
             item.transform = CGAffineTransform(scaleX: scale, y: scale)
             }
        }
        
        return section
        
    }
    func drawBottomSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 16, bottom: 16, trailing: 0)
//        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
//             items.forEach { item in
//             let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
//             let minScale: CGFloat = 0.8
//             let maxScale: CGFloat = 1.0
//             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
//             item.transform = CGAffineTransform(scaleX: scale, y: scale)
//             }
       // }
        
        return section
        
    }
    
    
    @IBAction func onFavClicked(_ sender: Any) {
        if(viewModel?.isFav ?? false){
            viewModel?.deleteLeague()
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
        }else{
            viewModel?.insertLeague()
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        
    }
    
}

extension UIImageView{
    func setCustomImage(image : UIImageView, url : URL?){
        let processor = DownsamplingImageProcessor(size: image.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        image.kf.indicatorType = .activity
    
        image.kf.setImage(
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
    }
}
