//
//  NoteType.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/21.
//

import SwiftUI

enum NoteType {
    case new(NoteItem)
    case edit(NoteItem)
}

extension NoteType {
    var title: String {
        switch self {
        case .new:
            return "新笔记"
        case .edit:
            return "编辑笔记"
        }
    }
    
    var noteItem: Binding<NoteItem> {
        .constant(value)
    }
    
    var value: NoteItem {
        switch self {
        case .new(let noteItem):
            return noteItem
        case .edit(let noteItem):
            return noteItem
        }
    }
}
