//
//  NoteView.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/21.
//

import SwiftUI

struct NoteView: View {
    
    @State var noteType: NoteType
    
    @State var isEditing = false
    
    @Binding var showNoteView: Bool
    
    @Binding var noteItems: [NoteItem]
    
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                    Divider()
                    titleField
                    Divider()
                    contentField
                }
            .navigationBarTitle(noteType.title, displayMode: .inline)
                .navigationBarItems(leading: closeButton, trailing: saveButton)
        }
    }
    
    var titleField: some View {

        
        TextField("请输入标题", text: noteType.noteItem.title) { editingChanged in
            self.isEditing = editingChanged
        } onCommit: {
            
        }
        .padding()
    }
    
    var contentField: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: noteType.noteItem.content)
                .font(.system(size: 17))
                .padding()
            
            let value = noteType.noteItem
            
            if noteType.value.content.isEmpty {
                Text("请输入内容")
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.init(top: 24, leading: 20, bottom: 0, trailing: 0))
            } else {
                EmptyView()
            }
        }
    }
    
    var closeButton: some View {
        Button {
            self.showNoteView = false
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 17))
                .foregroundColor(.gray)
        }
    }
    
    var saveButton: some View {
        Button {
            self.showNoteView = false
            
            let noteItem = noteType.noteItem.wrappedValue
            
            switch noteType {
            case .new:
                noteItem.writeTime = getCurrentTime
                noteItems.insert(noteItem, at: 0)
            case .edit(_):
                let index = noteItems.firstIndex { $0.id == noteItem.id }
                if let index {
                    
                    let deleteItem = noteItems.remove(at: index)
                    deleteItem.writeTime = getCurrentTime
                    
                    if noteItems.isEmpty {
                        noteItems.append(deleteItem)
                    } else {
                        noteItems.insert(deleteItem, at: 0)
                    }
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
        format.dateFormat = "YYYY/MM/dd-HH:mm:ss"
        return format.string(from: Date())
    }
}

