//
//  EditNoteView.swift
//  TodoList
//
//  Created by Luca Hodge on 9/13/23.
//

import SwiftUI

struct EditNoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    private var selectedItem : Item?
    @State var text : String
    
    init(passedItem : Item?){
        if passedItem != nil {
            selectedItem = passedItem
            _text = State(initialValue: selectedItem!.text ?? "")
        } else {
            selectedItem = nil
            _text = State(initialValue: "")
        }
    }
    var body: some View {
        Form{
            Text(selectedItem == nil ? "nope" : String( selectedItem!.timestamp!.timeIntervalSinceNow))
            Section(header: Text("TODO")){
                TextField("Discription", text: $text, axis: .vertical)
    //                .textFieldStyle(.roundedBorder)
                    .lineLimit(5)
    //                .multilineTextAlignment(.leading)

            }
            if selectedItem != nil {
                Section(header: Text("Date created")){
                    Text(selectedItem!.timestamp!, formatter: itemFormatter)
                }
            }
            
            Section{
                Button(action: saveAction){
                    Text("save")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                        
            }
        }
        .navigationTitle(selectedItem == nil ? "New Note" : "Edit Note")
        .scrollContentBackground(.hidden)
        .background(selectedItem == nil ? newTodoColor() : todoColor(date: selectedItem!.timestamp!))
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    func saveAction()
    {
//        withAnimation
//        {
//            if selectedItem == nil
//            {
//                selectedItem = Item(context: viewContext)
//            }
//
//            selectedItem?.timestamp = Date()
//            selectedItem?.text = text
            
//            dateHolder.saveContext(viewContext)
//            self.presentationMode.wrappedValue.dismiss()
//        }
        withAnimation {
            if selectedItem == nil {
                let newItem = Item(context: viewContext)
                newItem.timestamp = Date()
                newItem.text = text
            }
            else {
                selectedItem!.text = text
            }
                        

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        self.presentationMode.wrappedValue.dismiss()

    }

}

struct EditNoteView_Previews: PreviewProvider {
//    let persistenceController = PersistenceController.shared
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    static var firstItem: Item? {
        let context = PersistenceController.preview.container.viewContext
        let fetchRequest = Item.fetchRequest()
        fetchRequest.fetchLimit = 1
        let results = try? context.fetch(fetchRequest)
        return results?.first
    }

    static var previews: some View {
        VStack{
            if let firstItem {
                EditNoteView(passedItem: firstItem)
                    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

            }
            else {
                Text("Item not found")
            }
            
//                EditNoteView(passedItem: Item())
//                    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            
            //            EditNoteView(passedItem: nil).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
//        .environment(\.managedObjectContext, persistenceController.container.viewContext)

    }
}
