//
//  PlaylistAPI.swift
//  Plinic
//
//  Created by Jaewon on 2022/10/25.
//

import Foundation

final class PlaylistAPI: ObservableObject {
    
    private let basePath: String = "/plinic/playlists"
    
    private let networkService = NetworkService.init()
    private let jsonDecoder: DefaultJsonDecoder = .init()
    
    /// 특정 플레이리스트의 ID 값으로 API 요청을 보내, 해당 플레이리스트의 상세 정보를 가져온 후 completion 을 호출합니다.
    func getPlaylistDetail(by id: Int, _ completion: @escaping (PlaylistDetail?) -> Void) {
        let requestPath: String = "\(basePath)/\(id)"
        
        networkService.request(path: requestPath, method: .get) { [self] result in
            switch result {
            case .success(let data):
                return completion(jsonDecoder.decode(PlaylistDetail.self, from: data))
            case .failure(let error):
                completion(nil)
            }
        }
    }
}
