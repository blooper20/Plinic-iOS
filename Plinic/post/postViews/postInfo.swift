//
//  postThumbnail.swift
//  Plinic
//
//  Created by MacBook Air on 2022/08/13.
//

import SwiftUI

struct postInfo: View {
    
    static let dateFormat : DateFormatter = {
        let formatter = DateFormatter()
        //        formatter.dateFormat = "YYYY.MM.DD"
        formatter.dateStyle = .long
        return formatter
    }()
    var today = Date()
    
    var profileImg : String // 유저의 프로필 사진
    var userName  : String // 유저의 닉네임
    var thumbnail : String // 게시글 썸네일 이미지
    var postContext : String // 게시글 내용
    var postName : String
    var heartCnt : String
    
    
    @State private var heart = false
    @State private var scrap = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack{
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 0.5)
                    .padding(.bottom, 5)
                // 게시글 간의 구분 선
                
                // 상단의 게시글 작성자 정보
                    .padding(.bottom, 5)
                HStack{
                    Image(profileImg)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(Circle()
                            .stroke(Color(red: 0.501, green: 0.93, blue: 0.601), lineWidth: 5))
                        .background(Color.green)
                        .frame(maxWidth: 50, maxHeight: 50, alignment: .leading)
                        .clipShape(Circle())
//                        .padding([.leading, .trailing], 10)
                    
                    VStack{ 
                        Text("\(userName)")
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(minWidth: 100, maxWidth: 300, minHeight: 10, maxHeight: 30, alignment: .leading)
                        // 유저 닉네임
                        Text("\(today, formatter : postInfo.dateFormat)")
                            .font(.system(size: 13))
                            .foregroundColor(Color.gray)
                            .frame(minWidth: 100, maxWidth: 300, minHeight: 10, maxHeight: 20, alignment: .leading)
                        // 날짜
                    }
                    Spacer()
                }
                
                Image("\(thumbnail)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(Color.green)
                    .frame(maxWidth: 390, maxHeight: 390)
                // 게시글 썸네일
                
                HStack{
                    
                    Button(action: {
                        self.heart.toggle()
                        // 클릭 했을 때 좋아요 기능 구현
                    }, label: {
                        
                        Image(systemName: heart ? "heart.fill" : "heart")
                            .font(.system(size: 31))
                        //                            .padding(.trailing,10)
                            .foregroundColor(Color.white)
                            .frame(width: 44, height: 44)
                            .padding(.leading, 5)
                    })
                    //                    .padding(.leading, 5)
                    // 좋아요 버튼
                    
                    Text("좋아요 \(heartCnt)개")
                        .foregroundColor(Color.white)
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: 150, maxHeight: 44, alignment: .leading)
                    //                        .padding(.leading, 5)
                    // 좋아요 개수 표시
                    
                    
                    Spacer()
                    Button(action: {
                        // 클릭 했을 때 공유기능 구현
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 31))
                        //                            .padding(.trailing,10)
                            .foregroundColor(Color.white)
                            .frame(width: 44, height: 44)
                    })
                    // 공유 버튼
                    
                    Button(action: {
                        self.scrap.toggle()
                        // 내 보관함에 저장기능 구현
                    }, label: {
                        Image(systemName: scrap ? "bookmark.fill" : "bookmark")
                            .font(.system(size: 31))
                            .foregroundColor(Color.white)
                            .frame(width: 44, height: 44)
                            .padding(.trailing, 5)
                    })
                    // 스크랩 버튼
                } // 게시글 하단의 버튼
                
                Text("\(postName)")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .heavy))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: 390, maxHeight: 44, alignment: .leading)
                    .padding(.leading, 5)
                // 게시글 제목
                HStack{
                    
                    Text("\(postContext)")
                        .foregroundColor(Color.white)
                        .font(.system(size: 15, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: 300, maxHeight: 42, alignment: .leading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .padding(.leading, 5)
                        .padding(.trailing, 20)
                    // 게시글 내용
                    
                    Button(action: {
                        // 자세히 보기 기능 구현
                    }, label: {
                        Text("더보기")
                            .padding(.trailing, 5)
                    })
                    // 게시글 더보기 버튼
                }
                
            }
        } // 검은 배경
    }
}


struct postInfo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            postInfo(profileImg: "random1", userName : "userName", thumbnail: "defaultImg", postContext : "ddddsdasdasd asdasasdasd asdasdasd asdasdasdfghjagsdfjkhg asfasdfjlhgasdjkhf  asdfjkhg", postName: "게시글 제목", heartCnt : "200000")
            postInfo(profileImg: "random1", userName : "userName", thumbnail: "defaultImg", postContext : "ddddsdasdasd asdasasdasd asdasdasd asdasdasdfghjagsdfjkhg asfasdfjlhgasdjkhf  asdfjkhg", postName: "게시글 제목", heartCnt : "200000")
                .previewDevice("iPhone 8")
        }
    }
}
