//
//  VideoFeedTableViewController.swift
//  VideoFeedSample
//
//  Created by Anthony Dudouit on 22/11/2024.
//

import UIKit
import VideoFeedSDK

class VideoFeedSampleTableViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    private var data: [DataType] = []
    private var mdtk: String!

    enum DataType {
        case carroussel
        case item(String)
    }

    convenience init(mdtk: String) {
        self.init()
        self.mdtk = mdtk
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self

        tableview.register(VideoFeedCarrouselTableViewCell.nib, forCellReuseIdentifier: "VideoFeedCarousselTableViewCell")

        data.append(contentsOf: (0...100).map { i in .item("Item \(i)") })

        data.insert(.carroussel, at: 4)

        tableview.reloadData()
    }
}

extension VideoFeedSampleTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch data[indexPath.row] {
            case .carroussel:
                return 300
            case .item:
                return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch data[indexPath.row] {
            case .carroussel:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VideoFeedCarousselTableViewCell", for: indexPath) as! VideoFeedCarrouselTableViewCell
                cell.load(with: mdtk, zoneId: 1, adunitPath: "/34631970/AdExchangeOutstream/display_video_feed", delegate: self)
                return cell
            case .item(let text):
                let cell = UITableViewCell()
                cell.textLabel?.text = text
                return cell
        }
    }
}

extension VideoFeedSampleTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(data[indexPath.row])")

    }
}

extension VideoFeedSampleTableViewController: VideoFeedCarousselDelegate {
    func didTapOnItem(at videoId: String) {
        print("didTapOnItem at \(videoId)")
        navigationController?.pushViewController(
            VideoFeedViewController(
                videoId: videoId,
                zoneId: 1,
                mdtk: mdtk,
                adunitPath: "/34631970/AdExchangeOutstream/display_video_feed"
            ),
            animated: true
        )
    }
}
