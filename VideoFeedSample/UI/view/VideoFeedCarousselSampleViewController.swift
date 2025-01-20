//
//  VideoFeedCarousselSampleViewController.swift
//  VideofeedV2Sample
//
//  Created by Anthony Dudouit on 22/11/2024.
//

import UIKit
import VideoFeedSDK

class VideoFeedCarousselSampleViewController: UIViewController {

    @IBOutlet weak var carrouselContainerview: UIView!

    private var carrouselView: VideoFeedCarrouselView?

    private var mdtk: String!

    convenience init(mdtk: String) {
        self.init()
        self.mdtk = mdtk
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.carrouselView = VideoFeedCarrouselView(frame: .zero)
        if let carrouselView_ = carrouselView {
            carrouselContainerview.addSubview(carrouselView_)
            carrouselView_.translatesAutoresizingMaskIntoConstraints = false

            carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .leading, relatedBy: .equal, toItem: carrouselContainerview, attribute: .leading, multiplier: 1.0, constant: 0))
            carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .trailing, relatedBy: .equal, toItem: carrouselContainerview, attribute: .trailing, multiplier: 1.0, constant: 0))
            carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .top, relatedBy: .equal, toItem: carrouselContainerview, attribute: .top, multiplier: 1.0, constant: 0))
            carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .bottom, relatedBy: .equal, toItem: carrouselContainerview, attribute: .bottom, multiplier: 1.0, constant: 0))
        }

        self.carrouselView?.load(with: mdtk)
    }
}
