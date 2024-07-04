//
//  PlaylistCreateView.swift
//  Plinic
//
//  Created by 유경덕 on 2022/08/20.
//

import SwiftUI

struct PlaylistCreateView: View {
    
    @StateObject var randomAPI: RandomAPI = RandomAPI()
    @State var imageUrl: String?
    
    @StateObject var genreAPI: GenreAPI = GenreAPI()
    @State var genres: [String]
    
    @State var playlistName: String = ""
    @State var musicCount: String = ""
    @State var musicTitle: String = ""
    @State private var someToggle = true
    @State var genre : String = ""
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            GeometryReader{ geo in
                VStack {
                    HStack {
                        ThumbnailView(imageUrl: imageUrl ?? "defaultImg")
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.MainColor, lineWidth: 1))
                            .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.25)
                            .padding([.leading, .trailing], 10)
                        
                        VStack(alignment: .trailing) {
                            ZStack(alignment: .leading){
                                if musicCount.isEmpty{
                                    Text("곡 개수를 입력하세요.")
                                        .foregroundColor(Color.gray)
                                        .padding(.leading, 10)
                                }
                                TextField("\(musicCount)", text: $musicCount)
                                    .keyboardType(.decimalPad)
                                    .foregroundColor(Color.MainColor)
                                    .padding(.leading, 10)
                            }
                            .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.067, alignment: .center)
                            .background(Color.BackgroundSubColor)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.MainColor, lineWidth: 1))
                            .padding(.bottom, 10)
                            .onSubmit {
                                musicCount = "\(musicCount)"
                                print("곡 개수 : \(musicCount)")
                            }
                            
                            Button(action: {
                                randomAPI.getThumbnailURL() { url in
                                    if let url = url {
                                        self.imageUrl = url
                                    }
                                }
                            }, label: {
                                Text("사진 변경")
                                    .fontWeight(.bold)
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.MainColor)
                                    .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.067, alignment: .center)
                                    .background(Color.BackgroundSubColor)
                                    .cornerRadius(10)
                                    .padding(.bottom, 10)
                            })
                            Toggle("공개/비공개", isOn: $someToggle)
                                .padding([.trailing, .leading], 5)
                                .toggleStyle(SwitchToggleStyle(tint: Color.green))
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.067, alignment: .center)
                                .background(Color.BackgroundSubColor)
                                .cornerRadius(10)
                                .padding(5)
                        }//VStack
                    }//HStack
                    .frame(height: 200)
                    .padding(.bottom, 10)
                    
                    
                    ZStack(alignment: .leading){
                        if playlistName.isEmpty{
                            Text("플레이리스트 제목을 입력하세요.")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 10)
                        }
                        TextField("\(playlistName)", text: $playlistName)
                            .foregroundColor(Color.MainColor)
                            .padding(.leading, 10)
                    }
                    .frame(width: geo.size.width, height: geo.size.height * 0.08, alignment: .center)
                    .background(Color.BackgroundSubColor)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.MainColor, lineWidth: 1))
                    .padding(.bottom, 10)
                    .onSubmit {
                        playlistName = "\(playlistName)"
                        print("플레이리스트 제목 : \(playlistName)")
                    }
                    
                    VStack(alignment: .trailing) {
                        Picker("Choose a first genre", selection: $genre) {
                            ForEach(genres, id: \.self) { genre in
                                Text(genre)
                                    .fontWeight(.bold)
                                    .font(.system(size: 24))
                                    .foregroundColor(Color.MainColor)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: geo.size.width, height: geo.size.height * 0.20)
                        .background(Color.BackgroundSubColor)
                        .cornerRadius(5)
                        .padding([.top, .bottom], 30)
                        .onAppear(){
                            genreAPI.getGenres() { genres in
                                if let genres = genres {
                                    self.genres = genres
                                }
                            }
                        }
                        
                        HStack{
                            Button(action: {
                                // 클릭 했을 때 플리생성 취소
                            }, label: {
                                Text("취소")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.MainColor)
                                    .frame(width: 60, height: 50)
                                    .background(Color.BackgroundSubColor)
                                    .cornerRadius(15)
                            })
                            Button(action: {
                                // 클릭 했을 때 플리생성 취소
                            }, label: {
                                Text("완료")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.MainColor)
                                    .frame(width: 60, height: 50)
                                    .background(Color.BackgroundSubColor)
                                    .cornerRadius(15)
                                
                            })
                        }//HStack
                    }//VStack
                }//VStack
            }
            .onTapGesture {
                hideKeyboard()
            } // 화면 터치 했을 때 키보드 내리기
        }//ZStack
    }
}


struct playlistCreate_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlaylistCreateView(genres: [""])
            PlaylistCreateView(genres: [""])
                .previewDevice("iPhone 12")
        }
    }
}
