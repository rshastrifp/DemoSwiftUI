//
//  DetailsView.swift
//  ClearToDo
//
//  Created by Ronak Shastri on 2024-06-04.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var viewModel: DetailsViewModel = DetailsViewModel()
    
    var body: some View {
        Group {
            if $viewModel.posts.isEmpty {
                ProgressView {
                    Text("Loading..")
                }
            } else {
                List(viewModel.posts, id: \.id) { post in
                    Text(post.title)
                }
            }
        }
        .onAppear {
            viewModel.fethPosts()
        }
        
    }
}

#Preview {
    DetailsView()
}
