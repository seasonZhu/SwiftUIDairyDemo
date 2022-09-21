//
//  Model.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/20.
//

import Foundation

class NoteItem: ObservableObject, Identifiable, Comparable {
    static func == (lhs: NoteItem, rhs: NoteItem) -> Bool {
        lhs.writeTime == rhs.writeTime
        && lhs.title == rhs.title
        && lhs.content == rhs.content
        && lhs.id == rhs.id
    }
    
    static func < (lhs: NoteItem, rhs: NoteItem) -> Bool {
        lhs.writeTime < rhs.writeTime
    }
    
    var id = UUID()
    
    @Published var writeTime: String = ""
    @Published var title: String = ""
    @Published var content: String = ""
    
    init(writeTime: String, title: String, content: String) {
        self.writeTime = writeTime
        self.title = title
        self.content = content
    }
}
