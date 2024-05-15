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
    var communicator : Communicator?
    var isNoUpcomingEvents : Bool = false
    var isNoPastEvents : Bool = false
    var isNoTeams : Bool = false
    let indicator = UIActivityIndicatorView(style: .large)
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
        indicator.center = self.view.center
        indicator.startAnimating()
        self.view.addSubview(indicator)
        viewModel?.getPastEvents(complitionHandler: {
            self.indicator.stopAnimating()
            self.collectionView.reloadData()
        })
        viewModel?.getUpcomingEvents( complitionHandler: {
            self.indicator.stopAnimating()
            self.collectionView.reloadData()
        })
        viewModel?.getTeams(complitionHandler: {
            self.indicator.stopAnimating()
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
        switch section{
        case 0:
            var count = viewModel?.getUpcomingEventsCount() ?? 0
            if(count == 0){
                isNoUpcomingEvents = true
                count = 1
            }
            else{
                isNoUpcomingEvents = false
            }
            return count
        case 1:
            var count = viewModel?.getPastEventsCount() ?? 0
            if(count == 0){
                isNoPastEvents = true
                count = 1
            }
            else{
                isNoPastEvents = false
            }
            return count
        default:
            var count = viewModel?.getTeamCount() ?? 0
            if(count == 0){
                isNoTeams = true
                count = 1
            }
            else{
                isNoTeams = false
            }
            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEvent", for: indexPath) as! UpcomingEventCollectionViewCell
            if(isNoUpcomingEvents){
                cell.homeTeamName.isHidden = true
                cell.awayTeamName.isHidden = true
                cell.leagueNameLabel.isHidden = true
                cell.eventTimeLabel.isHidden = true
                cell.eventDateLabel.isHidden = true
                cell.awayTeamImage.isHidden = true
                cell.homeTeamImage.isHidden = true
                cell.noUpcomingEventsLabel.isHidden = false
            }
            else{
                cell.homeTeamName.text = viewModel?.getUpcomingEventsList()[indexPath.row].eventHomeTeam
                cell.awayTeamName.text = viewModel?.getUpcomingEventsList()[indexPath.row].eventAwayTeam
                cell.leagueNameLabel.text = viewModel?.getUpcomingEventsList()[indexPath.row].leagueName
                cell.eventTimeLabel.text = viewModel?.getUpcomingEventsList()[indexPath.row].eventTime
                cell.eventDateLabel.text = viewModel?.getUpcomingEventsList()[indexPath.row].eventDate
                cell.awayTeamImage.setCustomImage(url: URL(string: viewModel?.getUpcomingEventsList()[indexPath.row].awayTeamLogo ?? ""), placeholder: "team")
                cell.homeTeamImage.setCustomImage( url: URL(string: viewModel?.getUpcomingEventsList()[indexPath.row].homeTeamLogo ?? ""), placeholder: "team")
                cell.homeTeamName.isHidden = false
                cell.awayTeamName.isHidden = false
                cell.leagueNameLabel.isHidden = false
                cell.eventTimeLabel.isHidden = false
                cell.eventDateLabel.isHidden = false
                cell.awayTeamImage.isHidden = false
                cell.homeTeamImage.isHidden = false
                cell.noUpcomingEventsLabel.isHidden = true
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pastEvent", for: indexPath) as! PastEventCollectionViewCell
            if(isNoPastEvents){
                cell.homeTeamName.isHidden = true
                cell.awayTeamName.isHidden = true
                cell.eventResultText.isHidden = true
                cell.awayTeamImage.isHidden = true
                cell.homeTeamImage.isHidden = true
                cell.noPastEventsLabel.isHidden = false
            }
            else{
                cell.homeTeamName.text = viewModel?.getPastEventsList()[indexPath.row].eventHomeTeam
                cell.awayTeamName.text = viewModel?.getPastEventsList()[indexPath.row].eventAwayTeam
                cell.eventResultText.text = viewModel?.getPastEventsList()[indexPath.row].eventFinalResult
                cell.awayTeamImage.setCustomImage(url: URL(string: viewModel?.getPastEventsList()[indexPath.row].awayTeamLogo ?? ""), placeholder: "team")
                cell.homeTeamImage.setCustomImage(url: URL(string: viewModel?.getPastEventsList()[indexPath.row].homeTeamLogo ?? ""), placeholder: "team")
                cell.homeTeamName.isHidden = false
                cell.awayTeamName.isHidden = false
                cell.eventResultText.isHidden = false
                cell.awayTeamImage.isHidden = false
                cell.homeTeamImage.isHidden = false
                cell.noPastEventsLabel.isHidden = true
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teams", for: indexPath) as! TeamsCollectionViewCell
            if(isNoTeams){
                cell.teamName.isHidden = true
                cell.teamImage.isHidden = true
                cell.noTeamsLabel.isHidden = false
            }
            else{
                cell.teamName.text = viewModel?.getTeamsList()[indexPath.row].teamName
                cell.teamImage.setCustomImage(url: URL(string: viewModel?.getTeamsList()[indexPath.row].teamLogo ?? ""), placeholder: "team")
                cell.teamName.isHidden = false
                cell.teamImage.isHidden = false
                cell.noTeamsLabel.isHidden = true
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Reachability.isConnectedToNetwork(){
                   if(indexPath.section == 2){

                       if let teamDetailViewController = self.storyboard?.instantiateViewController(identifier: "teamDetails") as? TeamDetailsViewController{
                           teamDetailViewController.viewModel = TeamDetailsViewModel(teamDetails: viewModel!.getTeamsList()[indexPath.row])
                           self.present(teamDetailViewController, animated: true)
                       }
                   }
               }else{
                   self.showNetworkAlertAlert()
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
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)
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
//        item.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 16, bottom: 16, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(160))
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
    
    
    @IBAction func onFavClicked(_ sender: Any) {
        if(viewModel?.isFav ?? false){
            self.showAlert()
        }else{
            viewModel?.insertLeague()
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            viewModel?.isFav = true
        }
        communicator?.updateList()
    }
    
    
    @IBAction func onDismiss(_ sender: Any) {
        self.dismiss(animated: true
        )
    }
    func showNetworkAlertAlert(){
       let alert = UIAlertController(title: "Network Alert", message: "No Network available, plese check your networ connection", preferredStyle: UIAlertController.Style.alert)

       let action2 = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
       alert.addAction(action2)
       self.present(alert, animated: true)
   }

   func showAlert(){
       let alert = UIAlertController(title: "Delete League", message: "Are you sure you want to delete league from favorite?", preferredStyle: UIAlertController.Style.alert)
       let action = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: {_ in
           self.viewModel?.deleteLeague()
           self.favButton.setImage(UIImage(systemName: "star"), for: .normal)
           self.viewModel?.isFav = false
           self.communicator?.updateList()
       }
       )
       let action2 = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
       alert.addAction(action)
       alert.addAction(action2)
       self.present(alert, animated: true)
   }

}

extension UIImageView{
    func setCustomImage(url : URL?, placeholder: String){
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        self.kf.indicatorType = .activity
    
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: placeholder),
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
