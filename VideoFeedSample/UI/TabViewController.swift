//
//  TabViewController.swift
//  VideoFeedSample
//
//  Created by Anthony Dudouit on 16/04/2025.
//

import UIKit
import VideoFeedSDK

class TabViewController: UITabBarController {

    private let defaultMdtk = "01470628"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    func setup() {

        let examplesVC = ExamplesViewController()
        if #available(iOS 13.0, *) {
            examplesVC.tabBarItem = UITabBarItem(title: "Examples", image: UIImage(systemName: "house"), tag: 0)
        } 

        let videoFeedVC = VideoFeedViewController(mdtk: defaultMdtk)
        if #available(iOS 13.0, *) {
            videoFeedVC.tabBarItem = UITabBarItem(title: "Video Feed", image: UIImage(systemName: "film"), tag: 1)
        }
        
        self.viewControllers = [UINavigationController(rootViewController: examplesVC), videoFeedVC]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
