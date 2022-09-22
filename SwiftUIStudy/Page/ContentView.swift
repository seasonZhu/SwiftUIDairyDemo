//
//  ContentView.swift
//  SwiftUIStudy
//
//  Created by dy on 2022/9/20.
//

import SwiftUI

struct ContentView: View {
    /// 数组是不能用@StateObject修饰的,ObservableObject协议只能由class遵守
    @State var noteItems: [NoteItem]
    
    @State var new = NoteItem(writeTime: "", title: "", content: "")
    
    @State var searchText = ""
    
    @State var showNewNoteView = false
    
    @State var isEdit = false
    
    @State var showToast = false
    
    @State var showToastMessage: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if noteItems.isEmpty && !isEdit {
                    noDataView
                } else {
                    VStack {
                        searchView
                        NoteListView(noteItems: $noteItems)
                    }
                }
                addButton
                
            }
            .navigationBarTitle("一个笔记", displayMode: .inline)
            .toast(present: $showToast, message: $showToastMessage)
        }
        .sheet(isPresented: $showNewNoteView) {
            //NewNoteView(showNewNoteView: $showNewNoteView, noteItems: $noteItems, title: "", content: "")
            NoteView(noteType: .new(new), showNoteView: $showNewNoteView, noteItems: $noteItems)
        }
    }
    
    var noDataView: some View {
        VStack(spacing: 20) {
            Image("no_data")
                .resizable()
                .scaledToFit()
                .frame(width: 240)
            Text("记录下这个世界的点滴")
                .font(.system(size: 17))
                .bold().foregroundColor(.gray)
        }
    }
    
    var addButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    print("点击了添加按钮")
                    showNewNoteView = true
                    new = NoteItem(writeTime: "", title: "", content: "")
                } label: {
                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 48))
                                        .foregroundColor(.blue)
                }
                .padding(.bottom, 32)
                .padding(.trailing, 32)
            }

        }
    }
    
    var searchView: some View {
        TextField("搜索内容", text: $searchText)
            .makeToolBar()
            .keyboardType(.webSearch)
            .onSubmit {
                searchAction()
            }
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    if !searchText.isEmpty {
                        Button {
                            clearSearch()
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }

                    }
                }
            }
            .padding(.horizontal, 10)
        
    }
}

extension ContentView {
    private func searchAction() {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showToast = true
            showToastMessage = "搜素关键词不能为空"
            return
        }
        
        isEdit = true
        let search = noteItems.filter { item in
            item.content.contains(searchText) || item.title.contains(searchText)
        }
        
        if search.isEmpty {
            showToast = true
            showToastMessage = "没有搜索到相关日记"
        } else {
            noteItems = search
        }
    }
    
    private func clearSearch() {
        searchText = ""
        isEdit = false
        noteItems = readData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(noteItems: [])
    }
}
