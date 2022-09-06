//
//  searchBar.swift
//  Plinic
//
//  Created by MacBook Air on 2022/09/06.
//

import SwiftUI

struct SearchBar: View {
    
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            HStack{
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 24))
                    .foregroundColor(Color(red: 0.503, green: 0.928, blue: 0.601))
                    .frame(width: 30, height: 30)
                ZStack(alignment: .leading){
                    if searchText.isEmpty{
                        Text("검색어를 입력하세요.")
                            .foregroundColor(Color.gray)
                    }
                    TextField("", text: $searchText)
                        .foregroundColor(Color.white)
                        .font(.title2)
                } // 텍스트 필드
                Button(action: {
                    searchText = ""
                }, label: {
                    //                    Text("취소")
                    //                        .padding(.trailing, 10)
                    Image(systemName: "x.circle.fill")
                        .padding(.trailing, 10)
                    //                                                .font(.system(size: 24))
                    //                            .foregroundColor(Color(red: 0.503, green: 0.928, blue: 0.601))
//                        .frame(width: 30, height: 30)
                })
            } // 검색어 창
            .padding(.leading)
            .frame(width: 390, height: 44)
            .background(Color(red: 0.108, green: 0.109, blue: 0.119))
            .cornerRadius(10)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}

