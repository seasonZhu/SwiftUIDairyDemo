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
    
    @State var searchText = ""
    
    @State var showNewNoteView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if noteItems.isEmpty {
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
        }.sheet(isPresented: $showNewNoteView) {
            NewNoteView(showNewNoteView: $showNewNoteView, noteItems: $noteItems, title: "", content: "")
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
                            self.searchText = ""
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(noteItems: [])
    }
}
