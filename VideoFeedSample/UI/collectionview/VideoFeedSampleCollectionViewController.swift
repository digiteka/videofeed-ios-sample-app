//
//  VideoFeedCollectionViewController.swift
//  VideofeedV2Sample
//
//  Created by Anthony Dudouit on 22/11/2024.
//

import UIKit
import VideoFeedSDK

class VideoFeedSampleCollectionViewController: UIViewController {

    @IBOutlet weak var collectionview: UICollectionView!

    private var data: [DataType] = []
    private var numberOfItemsInRow = 2
    private var minimumSpacing: CGFloat = 5
    private var edgeInsetPadding: CGFloat = 10
    private var mdtk: String!

    enum DataType {
        case carroussel
        case item(String, UIColor)
    }

    convenience init(mdtk: String) {
        self.init()
        self.mdtk = mdtk
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionview.register(
            VideoFeedCarrouselCollectionViewCell.nib,
            forCellWithReuseIdentifier: "VideoFeedCarrouselCollectionViewCell"
        )
        collectionview.register(
            UINib(nibName: "VideoFeedSampleCollectionViewCell", bundle: Bundle.main),
            forCellWithReuseIdentifier: "VideoFeedSampleCollectionViewCell"
        )

        data.append(contentsOf: (0...100).map { i in .item("Item \(i)", UIColor.random()) })
        data.insert(.carroussel, at: 4)
        collectionview.reloadData()
    }

}

extension VideoFeedSampleCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data[indexPath.row] {
            case .carroussel:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoFeedCarrouselCollectionViewCell", for: indexPath) as! VideoFeedCarrouselCollectionViewCell
                cell.load(with: mdtk, delegate: self)
                return cell
            case .item(let text, let color):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoFeedSampleCollectionViewCell", for: indexPath) as! VideoFeedSampleCollectionViewCell
                cell.textLabel?.text = text
                cell.contentView.backgroundColor = color
                return cell
        }
    }

}

extension VideoFeedSampleCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected \(data[indexPath.row])")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch data[indexPath.row] {
            case .carroussel:
                return CGSize(width: collectionView.bounds.size.width - 10, height: 300)
            case .item:
                let spacing = (numberOfItemsInRow - 1) * Int(minimumSpacing)
                let width = (Int(collectionView.bounds.size.width) - spacing - Int(edgeInsetPadding))
                let widthForItem = width / numberOfItemsInRow
                return CGSize(width: widthForItem, height: 100)
        }
    }
}

extension VideoFeedSampleCollectionViewController: VideoFeedCarousselDelegate {
    func didTapOnItem(at videoId: String) {
        self.navigationController?.pushViewController(VideoFeedViewController(videoId: videoId, mdtk: mdtk), animated: true)
    }
}

extension UIColor {
    static func random() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5

        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}
