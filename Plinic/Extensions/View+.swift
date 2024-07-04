//
//  View+.swift
//  Plinic
//
//  Created by Jaewon on 2022/10/23.
//

import SwiftUI

extension View {
    
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        return modifier(ViewDidLoadModifier.init(perform: action))
    }
    
    /// 다른 부분 탭했을 때 키보드 숨기는 함수
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
