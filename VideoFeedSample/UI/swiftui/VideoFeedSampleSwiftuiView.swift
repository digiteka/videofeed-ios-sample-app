//
//  VideoFeedSampleSwiftuiView.swift
//  VideofeedV2Sample
//
//  Created by Anthony Dudouit on 22/11/2024.
//

import SwiftUI
import VideoFeedSDK

@available(iOS 13.0, *)
struct VideoFeedSampleSwiftuiView: View {
    @State private var isVideoFeedPresented = false

    @State private var videoId: String = ""
    @State private var zoneId: Int = 0

    let mdtk: String

    var body: some View {

        VStack {
            NavigationLink(
                destination: VideoFeedViewSUI(
                    videoId: videoId,
                    zoneId: zoneId,
                    mdtk: self.mdtk,
                    onLinkActivated: { url in
                        print("Link activated: \(url)")
                    }
                ),
                isActive: $isVideoFeedPresented
            ) {
                EmptyView()
            }
            Text("SwuitUI CarrouselView")



            VideoFeedCarrouselViewSUI(mdtk: mdtk, zoneId: 1) { videoId in
                print("Selected videoId: \(videoId)")
                self.videoId = videoId
                self.zoneId = 1
                self.isVideoFeedPresented = true
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)

            VideoFeedCarrouselViewSUI(mdtk: mdtk) { videoId in
                print("Selected videoId: \(videoId)")
                self.videoId = videoId
                self.zoneId = 0
                self.isVideoFeedPresented = true
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
        }


    }
}
