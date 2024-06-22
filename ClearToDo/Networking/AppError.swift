//
//  CustomError.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-06.
//

import Foundation

enum AppError: Error {
    case customError(code: String, message: String)
    case networkError(message: String)
    case decodingError
}
