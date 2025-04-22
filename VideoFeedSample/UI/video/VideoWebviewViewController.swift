//
//  VideoWebviewViewController.swift
//  VideoFeedSample
//
//  Created by Anthony Dudouit on 27/02/2025.
//

import UIKit
import WebKit
import VideoFeedSDK

class VideoWebviewViewController: UIViewController {

    @IBOutlet weak var webContainer: UIView!

    private var webview: WKWebView!
    private var mdtk: String!

    convenience init(mdtk: String) {
        self.init()
        self.mdtk = mdtk
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWebview()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if #available(iOS 15.0, *) {
            self.webview.pauseAllMediaPlayback {
                print("paused")
            }
        } else {
            // Fallback on earlier versions
        }
    }

    private func setupWebview() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "iOSjsHandler")
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        self.webview = WKWebView(frame: self.webContainer.bounds, configuration: config)

        self.webContainer.addSubview(webview)
        let contentHTML = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script>
            window.addEventListener('message', function(e) {
                window.webkit.messageHandlers.iOSjsHandler.postMessage(e.data);
            });
        </script>
        <body id="bodyy">
            <div id="container" class="content">
                <iframe width="100%" height="100%" src="https://www.ultimedia.com/deliver/generic/iframe/mdtk/01857682/zone/1/showtitle/1/src/xkx5zlf/chromeless/1" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" hspace="0" vspace="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"  referrerpolicy="no-referrer-when-downgrade"></iframe> 
            </div>
        </body>
        </html>
        """

        webview.loadHTMLString(contentHTML, baseURL: nil)

        if #available(iOS 16.4, *) {
            webview.isInspectable = true
        }
    }
}

extension VideoWebviewViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Received message from webview: \(message.body)")
        guard let messageBody = message.body as? String else { return }

        if messageBody.contains("trigger_vf_chromeless") {
            let id = messageBody.replacingOccurrences(of: "trigger_vf_chromeless-", with: "")
            let controller = VideoFeedViewController(videoId: id, mdtk: mdtk)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
