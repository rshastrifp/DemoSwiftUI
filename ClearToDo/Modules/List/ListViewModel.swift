//
//  ListViewModel.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-08.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    private var store = Set<AnyCancellable>()
    @Published var users = [User]()
    @Published var apiStatus: ApiStatus

    init(store: Set<AnyCancellable> = Set<AnyCancellable>(), users: [User] = [User]()) {
        self.store = store
        self.users = users
        self.apiStatus = .idle
    }
    
    func getUsers() {
        apiStatus = .loading
        UsersService()
            .getUsers()
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.apiStatus = .failure(error: error)
                }
            } receiveValue: { [weak self] (users: [User]) in
                guard let self = self else { return }
                self.apiStatus = .success(result: nil)
                self.users = users
                print(users)
            }
            .store(in: &store)
    }
    
}
