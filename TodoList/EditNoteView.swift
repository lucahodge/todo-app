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

//    @State var item : Item?
    @State var selectedItem : Item? = nil
    @State var text : String
    init(passedItem : Item?){
        if let selectedItem = passedItem {
//            if selectedItem.text == nil {
//                _text = State(initialValue: "passed")
//            } else {
//                _text = State(initialValue: selectedItem.text!)
//            }
//            _text = State(initialValue: selectedItem.text ?? "passed")
            _text = State(initialValue: "passed")
        } else {
            _text = State(initialValue: "no passed")
        }
//        _text = State(initialValue: "fail")
    }
    var body: some View {
        Form{
            Section(header: Text("TODO")){
                TextField("Discription", text: $text, axis: .vertical)
    //                .textFieldStyle(.roundedBorder)
                    .lineLimit(5)
    //                .multilineTextAlignment(.leading)

            }
            Section{
                Button(action: saveAction){
                    Text("save")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                        
            }
        }
    }
    
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
        self.presentationMode.wrappedValue.dismiss()

    }

}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            EditNoteView(passedItem: Item()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            EditNoteView(passedItem: nil).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }

    }
}
