//
//  RandomAPI.swift
//  Plinic
//
//  Created by Jaewon on 2022/10/22.
//

import Foundation

final class RandomAPI: ObservableObject {
    
    private let randomBackgroundPath: String = "/plinic/random-background/"
    private let randomThumbnailPath: String = "/plinic/random-thumbnail/"
    
    private let networkService = NetworkService.init()
    private let jsonDecoder: DefaultJsonDecoder = .init()
    
    /// API 요청을 보내 백그라운드에서 실행할 비디오 URL 을 랜덤으로 가져온 후 completion 을 호출합니다.
    func getBackgroundVideoURL(_ completion: @escaping (String?) -> Void) {
        networkService.request(path: randomBackgroundPath, method: .get, headers: nil) { [self] result in
            switch result {
            case .success(let data):
                return completion(jsonDecoder.decode(BackgroundVideo.self, from: data)?.backgroundVideoURL)
            case .failure(let error):
                completion(nil)
            }
        }
    }
    
    /// API 요청을 보내 플레이리스트 썸네일에 사용할 수 있는 이미지의 URL 을 랜덤으로 가져온 후 completion 을 호출합니다.
    func getThumbnailURL(_ completion: @escaping (String?) -> Void) {
        networkService.request(path: randomThumbnailPath, method: .get, headers: nil) { [self] result in
            switch result {
            case .success(let data):
                return completion(jsonDecoder.decode(RandomThumbnail.self, from: data)?.imageUrl)
            case .failure(let error):
                completion(nil)
            }
        }
    }
}
