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
    
    let tasks = [
            Task(title: "Task 1", description: "Description for Task 1"),
            Task(title: "Task 2", description: "Description for Task 2"),
            Task(title: "Task 3", description: "Description for Task 3")
        ]
    
    var body: some View {
        VStack {
            NavigationView {
                List(tasks) { task in
                    NavigationLink(destination: DetailsView()) {
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.headline)
                            Text(task.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle("To Dos")
            }
        }
        .navigationTitle("ToDos")
        .padding()
    }
}

#Preview {
    ListView()
}
