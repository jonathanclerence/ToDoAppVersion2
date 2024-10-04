//
//  ContentView.swift
//  ToDoV2
//
//  Created by Hanan Jonathan Clerence on 2024-10-04.
//

import SwiftUI

struct TaskItem: Identifiable, Hashable {
    var id: String = UUID().uuidString
    
    var title: String
    var description: String
    var isDone: Bool
}

struct ContentView: View {
    @State var tasks:[TaskItem] = []
    @State var displayAddTask: Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack {
                List(tasks) { item in
                    
                    HStack {
                        
                        Image(systemName: item.isDone ? "circle.fill" : "circle")
                        
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }.onTapGesture {
                            let index = tasks.firstIndex(where: {
                                $0.id == item.id
                            })
                            
                            guard let unwrappedIndex = index else { return }
                            
                            tasks[unwrappedIndex].isDone.toggle()
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("My Tasks")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("", systemImage: "plus") {
                        displayAddTask.toggle()
                    }
                }
            }
            .sheet(isPresented: $displayAddTask) {
                AddTask(tasks: $tasks)
            }
        }
        
    }
}

struct AddTask:View {
    
    @Binding var tasks:[TaskItem]
    @State var newtask: TaskItem = TaskItem(title: "" ,description: "", isDone: false)
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            Form {
                VStack {
                    TextField("Enter a task", text: $newtask.title)
                    TextField("Enter a description", text: $newtask.description)
                    
                }
                .navigationTitle("New Task")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Add") {
                            tasks.append(newtask)
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .topBarLeading){
                        Button("Cancel") {
                            dismiss()
                        }
                        .tint(.red)
                    }
                }
            }
            

        }
        
    }
}

#Preview {
    ContentView()
}
