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
    @Query (sort:\.timestamp, order: .reverse) private var items: [Item]
    @State private var newTitle: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("What NOT to do?", text: $newTitle)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Button(action: addItem) {
                        Text("Add")
                    }
                    .padding(.trailing)
                }
                if items.isEmpty {
                    Text("Your list is empty. \nCreate something that you shouldn't do. \nHow about avoid heavy foods?")
                        .font(.title2)
                        .padding()
                        .padding(.top, 100)
                }
                List {
                    ForEach(items) { item in
                        HStack {
                            Text(item.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            HStack {
                                ActionButton("minus") {
                                    updateItemCount(item, action: "-")
                                }
                                
                                Text("\(item.count)").frame(width: 30)
                                
                                ActionButton("plus") {
                                    updateItemCount(item, action: "+")
                                }
                            }
                        }
                        
                    }
                    .onDelete(perform: deleteItems)
                }
                .selectionDisabled(true)
            }
            .navigationTitle("Don't Do List")
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
    
    private func updateItemCount(_ item: Item, action: String) {
        if action == "-" && item.count > 0 {
            item.count -= 1
        } else {
            item.count += 1
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

struct ActionButton: View {
    let icon: String
    let actionCall: () -> Void
    
    init(_ icon: String, actionCall: @escaping () -> Void) {
        self.icon = icon
        self.actionCall = actionCall
    }
    
    var body: some View {
        Button {
            actionCall()
        } label: {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Color.blue)
                .padding(10)
                .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: false)
}
