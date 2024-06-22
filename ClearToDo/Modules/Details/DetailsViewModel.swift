//
//  DetailsViewModel.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-20.
//

import Foundation
import Combine

class DetailsViewModel: ObservableObject {
    
    private var store = Set<AnyCancellable>()
    @Published var posts = [PostElement]()
    @Published var apiStatus: ApiStatus
    var selectedUserId: Int
    
    init(store: Set<AnyCancellable> = Set<AnyCancellable>(), posts: [PostElement] = [PostElement](), selectedUser: Int) {
        self.store = store
        self.posts = posts
        self.selectedUserId = selectedUser
        self.apiStatus = .idle
    }
    
    func fethPosts() {
        self.apiStatus = .loading
        PostService()
            .fetchPosts(queryParameter: ["userId": String(selectedUserId)])
            .sink { [weak self] completionResult in
                guard let self = self else { return }
                switch completionResult {
                case .finished: 
                    print("Finish successful.")
                    break
                case .failure(let error):
                    print(error)
                    self.apiStatus = .failure(error: error)
                }
            } receiveValue: { [weak self] posts in
                guard let self = self else { return }
                self.apiStatus = .success(result: nil)
                self.posts = posts
            }
            .store(in: &store)
    }
    
}
