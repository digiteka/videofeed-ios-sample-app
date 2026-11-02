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

## Ad Targeting Parameters

All SDK views and view controllers accept the following optional ad targeting parameters:

| Parameter | Type | Description |
|-----------|------|-------------|
| `adunitPath` | `String?` | The GAM ad unit path (e.g. `"networkCode/pathToAd"`). Used for banner/in-stream ad targeting. |
| `adunitPathInterstitial` | `String?` | The GAM ad unit path for interstitial ads. |
| `custParams` | `String?` | Custom key-value targeting parameters passed to GAM as a query string (e.g. `"category=sport&env=prod"`). |
| `targetings` | `String?` | Additional targeting parameters passed to the video feed (e.g. `"section=home"`). |

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
        cell.load(
            with: mdtk,
            zoneId: 1,
            adunitPath: "networkCode/pathToAd",
            adunitPathInterstitial: "networkCode/pathToInterstitial",
            custParams: "category=sport",
            targetings: "section=home",
            delegate: self
        )
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
        cell.load(
            with: mdtk,
            zoneId: 1,
            adunitPath: "networkCode/pathToAd",
            adunitPathInterstitial: "networkCode/pathToInterstitial",
            custParams: "category=sport",
            targetings: "section=home",
            delegate: self
        )
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
self.carrouselView.load(
    with: mdtk,
    zoneId: 1,
    adunitPath: "networkCode/pathToAd",
    adunitPathInterstitial: "networkCode/pathToInterstitial",
    custParams: "category=sport",
    targetings: "section=home",
    delegate: self
)
```

The `backgroundCarrouselColor` parameter sets the background color of the carousel view (native layer and HTML body). It defaults to transparent:

```swift
self.carrouselView.load(with: mdtk, zoneId: 1, backgroundCarrouselColor: UIColor.black, delegate: self)
```

### Delegate

Each of the above views can take a delegate to handle user interactions and open the `VideoFeedViewController` as you need. 
The delegate must conform to the `VideoFeedCarousselDelegate` protocol:

```swift
extension VideoFeedSampleCollectionViewController: VideoFeedCarousselDelegate {
    func didTapOnItem(at videoId: String, zoneId: Int?) {
        self.navigationController?.pushViewController(VideoFeedViewController(videoId: videoId, zoneId: zoneId, mdtk: mdtk), animated: true)
    }
}
```

If the delegate is not set, it will present the `VideoFeedViewController` by itself.


## VideoFeedViewController

The `VideoFeedSDK` provide a `UIViewController` that you can use as you want

It can be used with a `videoId`, a `zoneId` and a `mdtk`. 
If no `videoId` is provided, it will display the first video of the feed.
if no `zoneId` is provided, it will use the first zone (id 1).

```swift
let videoFeedViewController = VideoFeedViewController(videoId: videoId, zoneId: zoneId, mdtk: mdtk, delegate: self)
let videoFeedViewController = VideoFeedViewController(videoId: videoId, zoneId: zoneId, mdtk: mdtk)
let videoFeedViewController = VideoFeedViewController(videoId: videoId, mdtk: mdtk)
let videoFeedViewController = VideoFeedViewController(mdtk: mdtk)
```

Ad targeting parameters are also available:

```swift
let videoFeedViewController = VideoFeedViewController(
    videoId: videoId,
    zoneId: zoneId,
    mdtk: mdtk,
    adunitPath: "networkCode/pathToAd",
    adunitPathInterstitial: "networkCode/pathToInterstitial",
    custParams: "category=sport",
    targetings: "section=home",
)
```

A parameter `showCloseButton` can be added to show or not a close button in the `VideoFeedViewController`.
```swift
let videoFeedViewController = VideoFeedViewController(mdtk: mdtk, showCloseButton: true)
```

The `VideoFeedViewController` accepts a `delegate` to manage click on external links:

```swift
public protocol VideoFeedDelegate: AnyObject {
    /// Called when an external link is tapped
    func handleExternalLink(url: URL)
}
```

## SwiftUI

### VideoFeedCarrouselViewSUI

`VideoFeedCarrouselViewSUI` is a custom SwiftUI view designed for displaying video feed items in a carousel-style layout:

```swift
var body: some View {
    
    VideoFeedCarrouselViewSUI(mdtk: mdtk, zoneId: 1)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)

    VideoFeedCarrouselViewSUI(mdtk: mdtk) { videoId, zoneId in
        print("Selected videoId: \(videoId) zoneId: \(zoneId)")
    }
    .frame(maxWidth: .infinity)
    .frame(height: 300)
}
 
```

Ad targeting parameters are also available:

```swift
VideoFeedCarrouselViewSUI(
    mdtk: mdtk,
    zoneId: 1,
    adunitPath: "networkCode/pathToAd",
    adunitPathInterstitial: "networkCode/pathToInterstitial",
    custParams: "category=sport",
    targetings: "section=home",
)
.frame(maxWidth: .infinity)
.frame(height: 300)
```

The `backgroundCarrouselColor` parameter sets the background color of the carousel view (native layer and HTML body). It defaults to transparent:

```swift
VideoFeedCarrouselViewSUI(mdtk: mdtk, zoneId: 1, backgroundCarrouselColor: UIColor.black)
    .frame(maxWidth: .infinity)
    .frame(height: 300)
```

### VideoFeedViewSUI

`VideoFeedViewSUI` is a custom SwiftUI view designed for displaying video feed items:

It can be used with a `videoId`, a `zoneId` and a `mdtk`. 
If no videoId is provided, it will display the first video of the feed.
If no zoneId is provided, it will use the first zone (id 1).

```swift
    VideoFeedViewSUI(videoId: videoId, zoneId: zoneId, mdtk: mdtk, onLinkActivated: { url in
                        print("Link activated: \(url)")
                    })
    VideoFeedViewSUI(mdtk: mdtk)
```

Ad targeting parameters are also available:

```swift
VideoFeedViewSUI(
    videoId: videoId,
    zoneId: zoneId,
    mdtk: mdtk,
    adUnitPath: "networkCode/pathToAd",
    adUnitPathInterstitial: "networkCode/pathToInterstitial",
    custParams: "category=sport",
    targetings: "section=home",
)
```

# Open the VideoFeed from a digiteka web player

Configure your webview containing the digiteka player to listen to js post message event

```swift
    let contentController = WKUserContentController()
    contentController.add(self, name: "iOSjsHandler")
    let config = WKWebViewConfiguration()
    config.userContentController = contentController
    let webview = WKWebView(frame: self.webContainer.bounds, configuration: config)
```

add in the html the script to listen and dispatch to your ios code

```js
<script>
    window.addEventListener('message', function(e) {
        window.webkit.messageHandlers.iOSjsHandler.postMessage(e.data);
    });
</script>
```

add the `WKScriptMessageHandler` protocol and catch the `trigger_vf_chromeless-{VIDEO_ID}` as follow:

```swift
extension VideoWebviewViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let messageBody = message.body as? String else { return }

        if messageBody.contains("trigger_vf_chromeless") {
            let id = messageBody.replacingOccurrences(of: "trigger_vf_chromeless", with: "")
            let controller = VideoFeedViewController(videoId: id, mdtk: mdtk)
            self.present(controller, animated: true, completion: nil)
        }
    }
}
```



# Compatibility

This library requires a deployment target of `iOS 12.0` or higher.

the SwiftUI components are available from `iOS 13.0` or higher.

# Sample app
You can test the Sample app using the mdtk : `01472001`.
