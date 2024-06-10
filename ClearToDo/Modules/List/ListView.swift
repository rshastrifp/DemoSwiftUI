//
//  ListView.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-03.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}

struct ListView: View {
    
    @StateObject var viewModel: ListViewModel = ListViewModel()
    
    var body: some View {
        VStack {
            NavigationView {
                if viewModel.users.isEmpty {
                    ProgressView {
                        Text("Loading.....")
                    }
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(destination: DetailsView()) {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                Text(user.username)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .navigationTitle("Users")
                }
            }
        }
        .padding()
        .onAppear() {
            viewModel.getUsers()
        }
    }
}

#Preview {
    ListView()
}
