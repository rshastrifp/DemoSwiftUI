//
//  DetailsView.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-04.
//

import SwiftUI
import Combine

struct DetailsView: View {
    @ObservedObject var viewModel: DetailsViewModel
    @State var shouldShowErrorAlert: Bool = false
    private var store = Set<AnyCancellable>()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if viewModel.apiStatus == .loading {
                ProgressView {
                    Text("Loading..")
                }
            } else {
                List(viewModel.posts, id: \.id) { post in
                    Text(post.title)
                }
            }
        }
        .navigationTitle("All Posts")
        .onReceive(viewModel.$apiStatus, perform: { newStatus in
            switch newStatus {
            case .failure(_):
                self.shouldShowErrorAlert = true
            default:
                break
            }
        })
        .onAppear {
            viewModel.fethPosts()
        }
        .alert(isPresented: $shouldShowErrorAlert, content: {
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
    DetailsView(viewModel: DetailsViewModel(selectedUser: 0))
}
