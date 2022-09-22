//
//  EditNoteView.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/21.
//

import SwiftUI

struct EditNoteView: View {
    
    @Binding var noteItem: NoteItem
    
    @State var isEditing = false
    
    @Binding var showEditNoteView: Bool
    
    @Binding var noteItems: [NoteItem]
    
    var body: some View {
        NavigationView {
            VStack{
                    Divider()
                    titleField
                    Divider()
                    contentField
                }
                .navigationBarTitle("编辑笔记", displayMode: .inline)
                .navigationBarItems(leading: closeButton, trailing: saveButton)
        }
    }
    
    var titleField: some View {
        TextField("请输入标题", text: $noteItem.title) { editingChanged in
            isEditing = editingChanged
        } onCommit: {
            
        }
        .makeToolBar()
        .padding()
    }
    
    var contentField: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $noteItem.content)
                .font(.system(size: 17))
                .padding()
            if noteItem.content.isEmpty {
                Text("请输入内容")
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(20)
            }
        }
    }
    
    var closeButton: some View {
        Button {
            showEditNoteView = false
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 17))
                .foregroundColor(.gray)
        }
    }
    
    var saveButton: some View {
        Button {
            showEditNoteView = false
            noteItem.writeTime = getCurrentTime
            
            let index = noteItems.firstIndex { $0.id == noteItem.id }
            if let index {
                let deleteItem = noteItems.remove(at: index)
                if noteItems.isEmpty {
                    noteItems.append(deleteItem)
                } else {
                    noteItems.insert(deleteItem, at: 0)
                }
            }
            saveData(noteItems: noteItems)
            
        } label: {
            Text("完成")
                .font(.system(size: 17))
        }
    }
    
    private var getCurrentTime: String {
        let format = DateFormatter()
        format.dateFormat = "YYYY,MM,dd-HH:mm:ss"
        return format.string(from: Date())
    }
}
