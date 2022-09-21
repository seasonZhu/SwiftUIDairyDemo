//
//  NoteType.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/21.
//

import Foundation

enum NoteType {
    case new
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
    
    var noteItem: NoteItem {
        switch self {
        case .new:
            return NoteItem(writeTime: "", title: "", content: "")
        case .edit(let noteItem):
            return noteItem
        }
    }
}
