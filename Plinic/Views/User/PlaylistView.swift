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
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            GeometryReader{ geo in
                VStack{
                    PlaylistInfoView(playlistDetail: $playlistDetail)
                        .frame(height: geo.size.height * 0.25)
                    WebView(requestURL: playlistDetail.totalURL)
                }
            }
        }
        .onAppear() {
            playlistAPI.getPlaylistDetail(by: id) { result in
                switch result {
                case .success(let playlistDetail):
                    self.playlistDetail = playlistDetail
                case .failure(let error):
                    print(error)
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

