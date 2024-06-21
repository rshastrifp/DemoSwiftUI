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
    var selectedUserId: Int
    
    init(store: Set<AnyCancellable> = Set<AnyCancellable>(), posts: [PostElement] = [PostElement](), selectedUser: Int) {
        self.store = store
        self.posts = posts
        self.selectedUserId = selectedUser
    }
    
    func fethPosts() {
        PostService()
            .fetchPosts(queryParameter: ["userId": String(selectedUserId)])
            .sink { completionResult in
                switch completionResult {
                case .finished: 
                    print("Finish successful.")
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] posts in
                guard let self = self else { return }
                self.posts = posts
            }
            .store(in: &store)
    }
    
}
