//
//  UserPlaylistView.swift
//  Plinic
//
//  Created by MacBook Air on 2022/08/01.
//

import SwiftUI

struct PlaylistView: View {
    
    @StateObject var playlistAPI = PlaylistAPI.init()
    
    @State var playlistDetail: PlaylistDetail = .createMock()
    @State var id: Int
    
    var youtubeUrl: String = YoutubeLinkStorage.randomUrl
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            GeometryReader{ geo in
                VStack{
                    PlaylistInfoView(playlistDetail: $playlistDetail)
                        .frame(height: geo.size.height * 0.25)
                    WebView(requestURL: youtubeUrl)
                }
            }
        }
        .onAppear() {
            playlistAPI.getPlaylistDetail(by: id) { playlistDetail in
                if let playlistDetail = playlistDetail {
                    self.playlistDetail = playlistDetail
                }
            }
        }
    }
}

struct UserPlaylist_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlaylistView(playlistDetail: .createMock(), id: 1)
            PlaylistView(playlistDetail: .createMock(), id: 1)
                .previewDevice("iPhone 8")
        }
    }
}

