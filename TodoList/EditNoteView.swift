//
//  EditNoteView.swift
//  TodoList
//
//  Created by Luca Hodge on 9/13/23.
//

import SwiftUI

struct EditNoteView: View {
//    @State var item : Item?
    @State var text : String
    init(passedItem : Item?){
//        if let item = passedItem {
//            _text = State(initialValue: item.text ?? "passed")
//        } else {
//            _text = State(initialValue: "no passed")
//        }
        _text = State(initialValue: "fail")
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
                Button(action: {}){
                    Text("save")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                        
            }
        }
    }
}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditNoteView(passedItem: Item())
    }
}
