//
//  SwiftUIStudyApp.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/20.
//

import SwiftUI

@main
struct SwiftUIStudyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(noteItems: readData())
        }
    }
}

extension SwiftUIStudyApp {
    private func readData() -> [NoteItem] {
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
