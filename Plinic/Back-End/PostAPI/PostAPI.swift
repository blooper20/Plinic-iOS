//
//  PostAPI.swift
//  Plinic
//
//  Created by Jaewon on 2022/10/22.
//

import Foundation

final class PostAPI: ObservableObject {
    
    private let basePath: String = "/plinic/posts"
    
    private let networkService = NetworkService.init()
    
    /// API 요청을 보내 가장 최근의 게시글 목록을 가져온 후 completion 을 호출합니다.
    /// 이 때, 다음 페이지를 가져올 수 있는 URL 이 있을 경우 다음 페이지의 게시글 목록을 가져옵니다.
    func getPostList(nextURL: String? = nil, _ completion: @escaping ((Result<PostList, Error>) -> Void)) {
        if let absoluteURL = nextURL {
            networkService.request(absolutePath: absoluteURL, headers: nil) { result in
                switch result {
                case .success(let data):
                    do {
                        let postList = try JSONDecoder.init().decode(PostList.self, from: data)
                        completion(.success(postList))
                    } catch let error {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            networkService.request(path: basePath, headers: nil) { result in
                switch result {
                case .success(let data):
                    do {
                        let postList = try JSONDecoder.init().decode(PostList.self, from: data)
                        completion(.success(postList))
                    } catch let error {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// API 요청을 보내 특정 ID 값에 해당하는 게시글의 상세 정보를 가져온 후 completion 을 호출합니다.
    func getPostDetail(id: Int, _ completion: @escaping ((Result<PostDetail, Error>) -> Void)) {
        let requestPath = "\(basePath)/\(id)"
        
        networkService.request(path: requestPath, method: .get) { result in
            switch result {
            case .success(let data):
                do {
                    let postDetail = try JSONDecoder.init().decode(PostDetail.self, from: data)
                    completion(.success(postDetail))
                } catch let error {
                    print("json decode 실패")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// API 요청을 보내 특정 게시글의 등록을 요청합니다.
    func createPost(by post: CreatePost, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        guard let uploadData = try? JSONEncoder().encode(post) else { return }
        
        print("!!!!!!!encoding success")
        
        networkService.uploadRequest(path: basePath, uploadData: uploadData) { result in
            switch result {
            case .success(let data):
                print(data)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
