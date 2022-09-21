//
//  View+Extension.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/21.
//

import SwiftUI

extension View {
    func saveData(noteItems: [NoteItem]) {
        let saveNoteItems = noteItems.map { SaveNoteItem(id: $0.id, writeTime: $0.writeTime, title: $0.title, content: $0.content)
        }
        
        let data = try? JSONEncoder().encode(saveNoteItems)
        if let data {
            UserDefaults.standard.setValue(data, forKey: "saveNoteItems")
        }
    }
    
    func readData() -> [NoteItem] {
        let data = UserDefaults.standard.value(forKey: "saveNoteItems") as? Data
        
        if let data {
            let saveNoteItems = try? JSONDecoder().decode([SaveNoteItem].self, from: data)
            
            if let saveNoteItems {
                let noteItems = saveNoteItems.map { NoteItem(id: $0.id, writeTime: $0.writeTime, title: $0.title, content: $0.content)
                }
                return noteItems
            } else {
                return []
            }
        } else {
            return []
        }
    }
}

