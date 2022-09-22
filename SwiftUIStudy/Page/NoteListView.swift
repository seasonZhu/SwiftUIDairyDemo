//
//  NoteListView.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/21.
//

import SwiftUI

struct NoteListView: View {
    @Binding var noteItems: [NoteItem]

    var body: some View {
        List {
            ForEach($noteItems) { noteItem in
                NoteListRow(noteItem: noteItem, noteItems: $noteItems)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button {
                            let offset = noteItems.firstIndex(of: noteItem.wrappedValue)
                            if let offset {
                                noteItems.remove(at: offset)
                                saveData(noteItems: noteItems)
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                        
                    }
            }
        }
        .listStyle(InsetListStyle())
    }
}
