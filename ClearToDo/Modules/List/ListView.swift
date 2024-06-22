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
    @State var shouldShowError: Bool = false
    
    var body: some View {
        VStack {
            NavigationView {
                if viewModel.apiStatus == .loading {
                    ProgressView {
                        Text("Loading.....")
                    }
                } else {
                    List(viewModel.users, id: \.id) { user in
                        NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(selectedUser: user.id))) {
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
        .onReceive(viewModel.$apiStatus, perform: { newStatus in
            switch newStatus {
            case .failure(_):
                self.shouldShowError = true
            default:
                break
            }
        })
        .onAppear() {
            viewModel.getUsers()
        }
        .alert(isPresented: $shouldShowError, content: {
            var errorMessage = "Something went wrong.!"
            if case ApiStatus.failure(let error) = viewModel.apiStatus {
                if let error = error as? AppError,
                   case AppError.customError(_, let message) = error {
                    errorMessage = message
                } else {
                    errorMessage = error.localizedDescription
                }
            }
            return Alert(title: Text("Opps!"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        })
    }
}

#Preview {
    ListView()
}
