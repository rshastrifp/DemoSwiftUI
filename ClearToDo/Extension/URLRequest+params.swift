//
//  URLRequest+params.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-21.
//

import Foundation

extension URLRequest {
    mutating func addQueryParameters(_ parameters: [String: String]) {
        guard var urlComponents = URLComponents(url: self.url!, resolvingAgainstBaseURL: false) else { return }
        var queryItems = urlComponents.queryItems ?? []
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = queryItems
        self.url = urlComponents.url
    }

    mutating func addHeaders(_ headers: [String: String]) {
        for (key, value) in headers {
            self.addValue(value, forHTTPHeaderField: key)
        }
    }
    
    mutating func addBodyParameters(_ parameters: [String: String]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            self.httpBody = jsonData
            self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            print("Failed to serialize body parameters: \(error.localizedDescription)")
        }
    }
}

