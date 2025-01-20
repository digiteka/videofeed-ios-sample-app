# Digiteka VideoFeed Framework

[![en](https://img.shields.io/badge/lang-en-red.svg)](ReadMe.md)
[![fr](https://img.shields.io/badge/lang-fr-blue.svg)](ReadMe.fr.md)

Digiteka VideoFeed library provides an interactive view to display lists of media content, sorted by categories.

# Installation

Simply add the dependency to your project using this solution:


## Swift Package Manager

You can integrate `VideoFeedSDK` as a Swift package by adding the following URL to the public package repository that you can add in Xcode:

`https://github.com/digiteka/videofeed-ios-build.git`

# Usage

## UIKit

### UICollectionView

The `VideoFeedCarousselCollectionViewCell` is a custom `UICollectionViewCell` designed for displaying video feed items in a carousel-style layout. 

In your `UIViewController` or `UICollectionViewController`, register the cell with your `UICollectionView using the following code snippet:

```swift
collectionView.register(
    VideoFeedCarousselCollectionViewCell.nib, // Load the nib file
    forCellWithReuseIdentifier: "VideoFeedCarousselCollectionViewCell" // Assign a unique identifier
)
```

To load the carroussel, you can use the following code snippet:

```swift
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // [...]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoFeedCarousselCollectionViewCell", for: indexPath) as! VideoFeedCarousselCollectionViewCell
        cell.load(with: mdtk, delegate: self)
        return cell
        // [...]
    }
```



### UITableView

The `VideoFeedCarrouselTableViewCell` is a custom `UITableViewCell` designed for displaying video feed items in a list-style layout.

In your `UIViewController` or `UITableViewController`, register the cell with your `UITableView` using the following code snippet:

```swift
tableView.register(
    VideoFeedCarrouselTableViewCell.nib, // Load the nib file
    forCellReuseIdentifier: "VideoFeedTableViewCell" // Assign a unique identifier
)
```

To load the carroussel, you can use the following code snippet:

```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // [...]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoFeedCarousselTableViewCell", for: indexPath) as! VideoFeedCarrouselTableViewCell
        cell.load(with: mdtk, delegate: self)
        return cell
        // [...]
    }
```

### UIView

The `VideoFeedCarrouselView` is a custom `UIView` designed for displaying video feed items in a carousel-style layout:

```swift
self.carrouselView = VideoFeedCarrouselView(frame: .zero)
if let carrouselView_ = carrouselView {
    carrouselContainerview.addSubview(carrouselView_)
    carrouselView_.translatesAutoresizingMaskIntoConstraints = false

    carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .leading, relatedBy: .equal, toItem: carrouselContainerview, attribute: .leading, multiplier: 1.0, constant: 0))
    carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .trailing, relatedBy: .equal, toItem: carrouselContainerview, attribute: .trailing, multiplier: 1.0, constant: 0))
    carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .top, relatedBy: .equal, toItem: carrouselContainerview, attribute: .top, multiplier: 1.0, constant: 0))
    carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .bottom, relatedBy: .equal, toItem: carrouselContainerview, attribute: .bottom, multiplier: 1.0, constant: 0))
}
```

To load the carroussel, you can use the following code snippet:

```swift
self.carrouselView.load(with: mdtk, adunitPath: "networkCode/pathToAd", delegate: self)
```

### Delegate

Each of the above views can take a delegate to handle user interactions and open the `VideoFeedViewController` as you need. 
The delegate must conform to the `VideoFeedCarousselDelegate` protocol:

```swift
extension VideoFeedSampleCollectionViewController: VideoFeedCarousselDelegate {
    func didTapOnItem(at videoId: String) {
        self.navigationController?.pushViewController(VideoFeedViewController(videoId: videoId, mdtk: mdtk), animated: true)
    }
}
```

If the delegate is not set, it will present the `VideoFeedViewController` by itself.


## VideoFeedViewController

The `VideoFeedSDK` provide a `UIViewController` that you can use as you want

It can be used with a `videoId` and a `mdtk`. 
If no videoId is provided, it will display the first video of the feed.

```swift
let videoFeedViewController = VideoFeedViewController(videoId: videoId, mdtk: mdtk)
let videoFeedViewController = VideoFeedViewController(mdtk: mdtk)
```
## SwiftUI

### VideoFeedCarrouselViewSUI

`VideoFeedCarrouselViewSUI` is a custom SwiftUI view designed for displaying video feed items in a carousel-style layout:

```swift
var body: some View {
    
    VideoFeedCarrouselViewSUI(mdtk: mdtk)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)

    VideoFeedCarrouselViewSUI(mdtk: mdtk) { videoId in
        print("Selected videoId: \(videoId)")
    }
    .frame(maxWidth: .infinity)
    .frame(height: 300)
}
 
```

### VideoFeedViewSUI

`VideoFeedViewSUI` is a custom SwiftUI view designed for displaying video feed items:

It can be used with a `videoId` and a `mdtk`. 
If no videoId is provided, it will display the first video of the feed.

```swift
    VideoFeedViewSUI(videoId: videoId, mdtk: mdtk)
    VideoFeedViewSUI(mdtk: mdtk)
```




# Compatibility

This library requires a deployment target of `iOS 12.0` or higher.

the SwiftUI components are available from `iOS 13.0` or higher.

# Sample app
You can test the Sample app using the mdtk : `01472001`.
