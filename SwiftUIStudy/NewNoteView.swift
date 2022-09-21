//
//  NewNoteView.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/20.
//

import SwiftUI

struct NewNoteView: View {
    
    @Binding var showNewNoteView: Bool
    
    @Binding var noteItems: [NoteItem]
    
    @State var title: String
    @State var isEditing = false
    
    @State var content: String
    
    var body: some View {
        NavigationView {
            VStack{
                    Divider()
                    titleField
                    Divider()
                    contentField
                }
                .navigationBarTitle("新笔记", displayMode: .inline)
                .navigationBarItems(leading: closeButton, trailing: saveButton)
        }
    }
    
    var titleField: some View {
        TextField("请输入标题", text: $title) { editingChanged in
            self.isEditing = editingChanged
        } onCommit: {
            
        }
        .padding()
    }
    
    var contentField: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $content)
                .font(.system(size: 17))
                .padding()
            if content.isEmpty {
                Text("请输入内容")
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(20)
            }
        }
    }
    
    var closeButton: some View {
        Button {
            self.showNewNoteView = false
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 17))
                .foregroundColor(.gray)
        }
    }
    
    var saveButton: some View {
        Button {
            let newNoteItem = NoteItem(writeTime: getCurrentTime, title: title, content: content)
            noteItems.insert(newNoteItem, at: 0)
            self.showNewNoteView = false
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
