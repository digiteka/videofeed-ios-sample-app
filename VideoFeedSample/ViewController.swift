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
        case playerVideo
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
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return carrousselData.count
            case 1:
                return videoFeedData.count
            case 2:
                return 1
            default:
                return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "Carroussel"
            case 1:
                return "VideoFeed"
            case 2:
                return "Player"
            default:
                return ""
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var option: OptionsType!
        switch indexPath.section {
            case 0:
                option = carrousselData[indexPath.row]
            case 1:
                option = videoFeedData[indexPath.row]
            default:
                option = .playerVideo
        }
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
            case .playerVideo:
                cell.textLabel?.text = "Player Video"
            case .none:
                cell.textLabel?.text = ""
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var option: OptionsType!
        switch indexPath.section {
            case 0:
                option = carrousselData[indexPath.row]
            case 1:
                option = videoFeedData[indexPath.row]
            default:
                option = .playerVideo
        }
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
            case .playerVideo:
                navigationController?.pushViewController(VideoWebviewViewController(mdtk: mdtk), animated: true)
            case .none:
                print("none")
        }
    }
}


