//
//  HomeCollectionViewController.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 13/05/2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout {
    
    var homeViewModel:HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewModel = HomeViewModel()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let _: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        
            return CGSize(width: (UIScreen.main.bounds.size.width/2)-10, height: CGFloat(100))
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return homeViewModel.getCount()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! HomeCollectionViewCell
        cell.sportImage.image = UIImage(named: homeViewModel.getSports()[indexPath.row].image)

        cell.sportName.text = homeViewModel.getSports()[indexPath.row].name
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var sportType : SportType!
        switch(indexPath.item){
        case 0:
            sportType = .football
        case 1:
            sportType = .tennis
        case 2:
            sportType = .cricket
        case 3:
            sportType = .basketball
        default:
            sportType = .football
        }
        print(sportType.rawValue)
        let allLeaguesViewModel = AllLeaguesViewModel(remoteDataSource: RemoteDataSource<APIResultSportLeagues>(), sportType: sportType)
        if let allLeaguesViewController = self.storyboard?.instantiateViewController(identifier: "allLeagues") as? AllLeaguesTableViewController{
            allLeaguesViewController.viewModel = allLeaguesViewModel
            self.navigationController?.pushViewController(allLeaguesViewController, animated: true)
        }
    }

}
