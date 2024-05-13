//
//  LeagueDetailsViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini9 on 13/05/2024.
//

import UIKit

class LeagueDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEvent", for: indexPath) as! UpcomingEventCollectionViewCell
            cell.homeTeamName.text = "Real Madrid"
            cell.awayTeamName.text = "Barcelona"
            cell.leagueNameLabel.text = "UEFA Champoins League"
            cell.eventTimeLabel.text = "10:00"
            cell.eventDateLabel.text = "12-5-2024"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pastEvent", for: indexPath) as! PastEventCollectionViewCell
            cell.homeTeamName.text = "Real Madrid"
            cell.awayTeamName.text = "Barcelona"
            cell.eventResultText.text = "2-0"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath)
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
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 0)
        
        
        return section
        
    }
}
