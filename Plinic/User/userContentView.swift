//
//  UserContentView.swift
//  Plinic
//
//  Created by 유경덕 on 2022/07/31.
//

import SwiftUI

struct UserContentView: View {
    
    let userAPI: UserAPI = .init()
    
    @State var userInfo: UserInfo = .createMock()
    
    @State private var postTransform = true
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack{
                
                GeometryReader{ geometry in
                    
                    VStack(spacing:0) {
                        
                        HStack(spacing:0) {
                            
                            Text("\(userInfo.nickName)")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(Color.white)
                                .tracking(-0.41)
                                .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.05, alignment: .leading)
                            //유저 이름
                            
                            NavigationLink(destination: playlistCreate()){
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 35))
                                    .foregroundColor(Color.MainColor)
                                    .padding(.trailing, 15.0)
                            }
                            // 플레이리스트 추가버튼
                            
                            Button(action: {
                                self.postTransform.toggle()
                            }, label: {
                                Image(systemName: "music.note.list")
                                    .padding(.trailing, 10.0)
                                    .font(.system(size: 35))
                                    .foregroundColor(Color.MainColor)
                            })
                            
                        }
                        .padding(.leading, 10.0)
                        // HStack : 타이틀 부분
                        
                        VStack{
                            
                            UserInfoView(
                                profileImg: "random1",
                                userInfo: $userInfo
                            )
                                .frame(height: geometry.size.height * 0.25)
                                .padding([.bottom,.top], 10)
                            // 유저 정보 부분
                            
                            if(self.postTransform) {
                                UserMyPlaylistView(playlistTitle: "플레이리스트 제목")
                                    .frame(height: geometry.size.height * 0.65)
                                Spacer()
                                    .frame(height: geometry.size.height * 0.15)
                            } else {
                                UserMyPostView(postTitle: "게시글 제목")
                                    .frame(height: geometry.size.height * 0.65)
                            }
                            
                        }
                        // VStack
                    }
                    // VStack
                }
                // GeometryReader
            }
            // VStack
        }
        // ZStack
    }
}

struct UserContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserContentView()
            UserContentView()
                .previewDevice("iPhone 8")
        }
    }
}

