//
//  ViewController.swift
//  VideoFeedSample
//
//  Created by Anthony Dudouit on 25/11/2024.
//

import UIKit
import SwiftUI
import VideoFeedSDK

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    private let defaultMdtk = "01470628"

    @IBOutlet weak var mdtkTextfield: UITextField!

    enum OptionsType: CaseIterable {
        case tableview
        case collectionview
        case view
        case swiftui
        case videofeed
    }


    var carrousselData: [OptionsType] = [.tableview, .collectionview, .view, .swiftui]
    var videoFeedData: [OptionsType] = [.videofeed]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self

        self.title = "VideoFeed Sample"
        
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return carrousselData.count
            case 1:
                return videoFeedData.count
            default:
                return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Carroussel" : "VideoFeed"
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let option = indexPath.section == 0 ? carrousselData[indexPath.row] : videoFeedData[indexPath.row]
        switch option {
            case .tableview:
                cell.textLabel?.text = "Tableview"
            case .collectionview:
                cell.textLabel?.text = "Collectionview"
            case .view:
                cell.textLabel?.text = "View"
            case .swiftui:
                cell.textLabel?.text = "SwiftUI"
            case .videofeed:
                cell.textLabel?.text = "VideoFeed"
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = indexPath.section == 0 ? carrousselData[indexPath.row] : videoFeedData[indexPath.row]

        var mdtk = self.defaultMdtk

        if mdtkTextfield.text != nil && mdtkTextfield.text != "" {
            mdtk = mdtkTextfield.text!
        }

        switch option {
            case .tableview:
                navigationController?.pushViewController(VideoFeedSampleTableViewController(mdtk: mdtk), animated: true)
            case .collectionview:
                navigationController?.pushViewController(VideoFeedSampleCollectionViewController(mdtk: mdtk), animated: true)
            case .view:
                navigationController?.pushViewController(VideoFeedCarousselSampleViewController(mdtk: mdtk), animated: true)
            case .swiftui:
                if #available(iOS 13.0, *) {
                    let vc = UIHostingController(rootView: VideoFeedSampleSwiftuiView(mdtk: mdtk))
                    navigationController?.pushViewController(vc, animated: true)
                }
            case .videofeed:
                navigationController?.pushViewController(VideoFeedViewController(mdtk: mdtk), animated: true)
        }
    }
}


