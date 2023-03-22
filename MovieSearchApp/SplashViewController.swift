//
//  SplashViewController.swift
//  Moviey
//
//  Created by Sıla Topal on 15.03.2023.
//

import UIKit
import Network

class SplashViewController: UIViewController {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")

    override func viewDidLoad() {
        //super.viewDidLoad()
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
            } else {
                print("There's no internet connection.")
                DispatchQueue.main.async{
                    let alert = UIAlertController(title: "Warning", message: "The Internet is not available", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }

        monitor.start(queue: queue)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            self.performSegue(withIdentifier: "goToMainScreen", sender: nil)
        }
    }
    

   

}
