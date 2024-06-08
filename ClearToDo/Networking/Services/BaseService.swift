//
//  BaseService.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-06.
//

import Foundation

protocol ServiceParameters {
    var pathParameter: String { get }
    var queryParameter: [String: String]? { get }
    var headerParameters: [String: String]? { get }
    var bodyParameters: [String: String]? { get }
}



class BaseService {
    
    let baseUrl = "https://jsonplaceholder.typicode.com/"
    
}
