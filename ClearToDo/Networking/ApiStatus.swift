//
//  ApiStatus.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-21.
//

import Foundation

enum ApiStatus: Equatable {
    case idle
    case loading
    case success(result: Any?)
    case failure(error: Error)
    
    static func == (lhs: ApiStatus, rhs: ApiStatus) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading):
            return true
        case (.success(_), .success(_)):
            return true
        case (.failure(let leftError), .failure(let rightError)):
            return leftError.localizedDescription == rightError.localizedDescription
        default:
            return false
        }
    }
}
