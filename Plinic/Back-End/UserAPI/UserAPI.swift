//
//  UserAPI.swift
//  Plinic
//
//  Created by Jaewon on 2022/10/23.
//

import Foundation

final class UserAPI: ObservableObject {
    
    private let basePath: String = "/accounts"
    
    private let networkService = NetworkService.init()
    
    /// 특정 유저 정보를 가져오는 함수
    func getUserInfo(by nickName: String, _ completion: @escaping ((Result<UserInfo, Error>) -> Void)) {
//        let detailPath: String = "/profiles/\(nickName)"
//        let requestPath: String = "\(basePath)\(detailPath)"
        
        // MARK: 아니 왜 직접 문자열로 주소를 입력하면 되고 변수로 주면 안되냐고
        networkService.request(absolutePath: "https://plinic-api-server.ml/api/v1/accounts/profiles/plinic/") { result in
            switch result {
            case .success(let data):
                do {
                    let userInfo = try JSONDecoder.init().decode(UserInfo.self, from: data)
                    completion(.success(userInfo))
                } catch let error {
                    print("JSON decode 실패")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getOtherUserInfo(by nickName: String, _ completion: @escaping ((Result<OtherUserInfo, Error>) -> Void)) {
        networkService.request(absolutePath: "https://plinic-api-server.ml/api/v1/accounts/profiles/\(nickName)/") { result in
            switch result {
            case .success(let data):
                do {
                    let userInfo = try JSONDecoder.init().decode(OtherUserInfo.self, from: data)
                    completion(.success(userInfo))
                } catch let error {
                    print("JSON decode 실패")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
