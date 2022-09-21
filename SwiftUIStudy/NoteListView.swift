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
            }
        }
        .listStyle(InsetListStyle())
    }
}
