//
//  NoteListRow.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/20.
//

import SwiftUI

struct NoteListView: View {
    @Binding var noteItems: [NoteItem]

    var body: some View {
        List {
            ForEach($noteItems) { noteItem in
                NoteListRow(noteItem: noteItem)
            }
        }
        .listStyle(InsetListStyle())
    }
}

struct NoteListRow: View {
    @Binding var noteItem: NoteItem
    
    @State var showEditNoteView = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(noteItem.writeTime)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Text(noteItem.title)
                    .font(.system(size: 17))
                    .foregroundColor(.black)
                Text(noteItem.content)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            
            Button {
                print(noteItem.id)
                showEditNoteView = true
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
                    .font(.system(size: 23))
            }
        }.sheet(isPresented: $showEditNoteView) {
            EditNoteView(noteItem: $noteItem, showEditNoteView: $showEditNoteView)
        }
    }
}
