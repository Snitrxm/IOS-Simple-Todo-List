//
//  ContentView.swift
//  First Project
//
//  Created by Andre Rocha on 14/07/2024.
//

import SwiftUI

private struct Todo: Identifiable {
    let id = UUID()
    var text: String
    var isComplete: Bool
}

struct ContentView: View {
    @State private var todo: String = ""
    @State private var isConfirmationDialogOpen = false
    @FocusState private var isTodoFieldFocused: Bool
    @State private var todoIdToDelete: UUID?
    
    @State private var todos: [Todo] = []
    
    var body: some View {
        VStack {
            ForEach($todos) { $todo in
                HStack {
                    Text(todo.text)
                    Spacer()
                    Button("Delete", role: .destructive ,action: {
                        todoIdToDelete = todo.id
                        isConfirmationDialogOpen = true }).confirmationDialog("aaa", isPresented: $isConfirmationDialogOpen){
                        Button("Confirm", role: .destructive, action: {
                            if let id = todoIdToDelete {
                                todos.removeAll { $0.id == id }
                            }
                        })
                    } message: { Text("You cannot undo this action") }
                }
            }
            HStack {
                TextField("Todo", text: $todo)
                    .focused($isTodoFieldFocused)
                    .textFieldStyle(.roundedBorder)
                
                Button("Create", action: {
                    todos.append(Todo(text: todo, isComplete: false))
                    todo = ""
                    isTodoFieldFocused = false
                })
            }
            
        }.padding()
    }
}

#Preview {
    ContentView()
}
