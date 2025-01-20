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

    let mdtk: String

    var body: some View {

            VStack {
                NavigationLink(destination: VideoFeedViewSUI(videoId: videoId, mdtk: self.mdtk), isActive: $isVideoFeedPresented) {
                    EmptyView()
                }
                Text("SwuitUI CarrouselView")



                VideoFeedCarrouselViewSUI(mdtk: mdtk)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)

                VideoFeedCarrouselViewSUI(mdtk: mdtk) { videoId in
                    print("Selected videoId: \(videoId)")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
            }


    }
}
