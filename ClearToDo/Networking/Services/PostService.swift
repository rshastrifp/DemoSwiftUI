//
//  PostService.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-20.
//

import Foundation
import Combine

class PostService: BaseService, ServiceParameters {
    var pathParameter: String = "posts"
    
    var queryParameter: [String : String]?
    
    var headerParameters: [String : String]?
    
    var bodyParameters: [String : String]?
    
    func fetchPosts() -> AnyPublisher<[PostElement], Error> {
        guard let url = URL(string: baseUrl + pathParameter) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: url)
        return ApiClient.shared.makeServiceCall(urlRequest: urlRequest)
    }
}

//MARK: Codable object of Posts
// MARK: - PostElement
struct PostElement: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
