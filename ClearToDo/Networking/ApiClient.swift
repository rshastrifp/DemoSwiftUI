//
//  ApiClient.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-06.
//

import Foundation
import Combine

class ApiClient {
    static let shared = ApiClient()
    
    func makeServiceCall<T: Decodable>(urlRequest: URLRequest) -> AnyPublisher<T, Error> {
        
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
