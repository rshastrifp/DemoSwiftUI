//
//  UsersService.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-06.
//

import Foundation
import Combine

class UsersService: BaseService, ServiceParameters {    
    var pathParameter: String = "users"
    
    var queryParameter: [String : String]?
    var headerParameters: [String : String]?
    var bodyParameters: [String : String]?
    
    init(queryParameter: [String : String]? = nil, headerParameters: [String : String]? = nil, bodyParameters: [String : String]? = nil) {
        self.queryParameter = queryParameter
        self.headerParameters = headerParameters
        self.bodyParameters = bodyParameters
    }
    
    func getUsers() -> AnyPublisher<[User], Error> {
        guard let url = URL(string: baseUrl + pathParameter) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        
        return ApiClient.shared.makeServiceCall(urlRequest: urlRequest)
    }
    
}


// MARK: - User
struct User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}
