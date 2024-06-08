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
    
    func getUsers() {
        UsersService()
            .getUsers()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    break
                }
            } receiveValue: { [weak self] (users: [User]) in
                guard let self = self else { return }
                self.users = users
                print(users)
            }
            .store(in: &store)
    }
    
}
