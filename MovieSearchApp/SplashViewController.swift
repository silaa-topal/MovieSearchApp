//
//  SplashViewController.swift
//  Moviey
//
//  Created by Sıla Topal on 20.03.2023.
//

import UIKit
import Network

class SplashViewController: UIViewController {
    
    @IBOutlet weak var splashLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")

    override func viewDidLoad() {
        //super.viewDidLoad()
        setupRemoteConfigDefaults()
        displayNewValues()
        fetchRemoteConfig()
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                    self.performSegue(withIdentifier: "goToMainScreen", sender: nil)
                }
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

      
    }
    
    func setupRemoteConfigDefaults() {
    let defaultValue = ["label_text": "Hello world!" as NSObject]
    remoteConfig.setDefaults(defaultValue)
    }
    
    func fetchRemoteConfig(){
    remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
    guard error == nil else { return }
    print("Got the value from Remote Config!")
    remoteConfig.activate()
    self.displayNewValues()
    }}
    
    func displayNewValues(){
    let newLabelText = remoteConfig.configValue(forKey: "label_text").stringValue ?? ""
    splashLabel.text = newLabelText
    }

    

   

}
