//
//  Shared.swift
//  SportPro
//
//  Created by JETSMobileLabMini6 on 15/05/2024.
//

import Foundation
import UIKit

class Shared {
    class func showNetworkAlertAlert(view:ViewController){
        let alert = UIAlertController(title: "Network Alert", message: "No Network available, plese check your networ connection", preferredStyle: UIAlertController.Style.alert)
        
        let action2 = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
        alert.addAction(action2)
        view.present(alert, animated: true)
    }
}
