//
//  NoticeAPI.swift
//  Plinic
//
//  Created by MacBook Air on 2022/10/23.
//

import Foundation

final class NoticeAPI: ObservableObject {
    
    private let basePath: String = "/plinic/notices"
    
    private let networkService = NetworkService.init()
    private let jsonDecoder: DefaultJsonDecoder = .init()
    
    /// API 요청으로 가장 최근 공지사항 한개를 가져온 다음 completion 을 호출합니다.
    func getRecentNotice(_ completion: @escaping (RecentNotice?) -> Void) {
        let requestPath: String = "\(basePath)?recent=true"
        
        networkService.request(path: requestPath) { [self] result in
            switch result {
            case .success(let data):
                return completion(jsonDecoder.decode(RecentNotice.self, from: data))
            case .failure(let error):
                return completion(nil)
            }
        }
    }
}
