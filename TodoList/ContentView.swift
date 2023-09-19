//
//  ContentView.swift
//  TodoList
//
//  Created by Luca Hodge on 9/13/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
//    private let colors = [Color.white, Color.green, Color.yellow, Color.orange, Color.red]
    

    var body: some View {
        NavigationView {
            ZStack{
                if items.count == 0 {
                    Text("No notes")
                }
                    List {
                        
                            ForEach(items) { item in
                                NavigationLink {
                                    //                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                    EditNoteView(passedItem: item)
                                } label: {
                                    //                            Text(item.timestamp!, formatter: itemFormatter)
                                    Text(item.text ?? "")
                                }
                                
                                
                                //                        .listStyle(.insetGrouped)
                                //                        .overlay(RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color(uiColor: .tertiaryLabel), lineWidth: 1))
                                .listRowBackground(todoColor(date: item.timestamp!))
                            }
                            .onDelete(perform: deleteItems)
                        
                    }
    //                .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
    //                .listBackground(Color.blue)
    //                .backgroundColor(Color.purple)

    //                .toolbar {
    //    #if os(iOS)
    //                    ToolbarItem(placement: .navigationBarTrailing) {
    //                        EditButton()
    //                    }
    //    #endif
    //                    ToolbarItem {
    //                        Button(action: addItem) {
    //                            Label("Add Item", systemImage: "plus")
    //                        }
    //                    }
    //                }

                

                VStack(){
                    Spacer()
                    HStack(){
                        Spacer()
                        NavigationLink(destination: EditNoteView(passedItem: nil)){
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                Text("New Note").font(.headline)
                            }
                        }
                        .padding(15)
//                        .foregroundColor(.white)
//                        .background(Color.accentColor)
                        .foregroundColor(Color.accentColor)
                        .background(.white)
                        .cornerRadius(30)
                        .padding(30)
//                        .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        //                .buttonStyle(.bordered)
        //                .buttonStyle(.borderedProminent)
                    }
                }
                
//                Button(action: {}){
//                    Image(systemName: "plus.circle.fill")
//                }
//                Image(systemName: "location.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .title1)
//                    )

//                Text("Select an item")
            }
//            .accentColor(Color.blue)
            .background(appColor(number: items.count))

        }
//        .navigationTitle("Todo List")
    }
    

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.text = "hey"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
