//
//  ContentView.swift
//  DontDoApp
//
//  Created by Nesim Tunç on 2023/06/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var newTitle: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("What NOT To Do?", text: $newTitle)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Button(action: addItem, label: {
                        Text("Add")
                    })
                    .padding(.trailing)
                }
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text(item.title)
                        } label: {
                            Text(item.title)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Don't Do These")
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !items.isEmpty {
                        EditButton()
                    }
                }
#endif
            }
        }
    }
    
    private func addItem() {
        if newTitle.isEmpty { return }
        
        withAnimation {
            let newItem = Item(title: newTitle)
            modelContext.insert(newItem)
            newTitle = ""
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: false)
}
