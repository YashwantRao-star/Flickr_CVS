//
//  ContentView.swift
//  Flickr_iOS_challenge
//
//  Created by Yashwant Rao on 19/02/24.
//

import SwiftUI

struct ContentView: View {
  @State private var search: String = ""
  @State private var filteredItem: [Item] = []
  @StateObject private var networkModel = NetworkModel()
  @State private var isNavigatedBack = false
  
  // MARK: - Perform search based on searched text
  private func performSearch(keyword: String) async throws {
    do {
      try await networkModel.fetchImages(search: keyword)
    } catch {
      print(error)
    }
  }
  
  private var items : [Item] {
    filteredItem.isEmpty ? networkModel.items : filteredItem
  }
  
  var body: some View {
    NavigationStack {
      ScrollView {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 50, maximum: 200)), count: 3), spacing:5) {
          ForEach(items, id: \.self) { item in
            NavigationLink (destination: DetailsView(currentItem: item)) {
              GridItemView(item: item.title, media: item.media.m)
            }
          }
        }
        .searchable(text: $search){
        }.accessibilityLabel("Search Bar")
          .onChange(of: search, { oldValue, newValue in
            Task {
              do {
                try await performSearch(keyword: search)
              }
              catch {
                print(error)
              }
            }
          })
        
          .padding()
      }
      .navigationTitle("Search Images")
      .onAppear {
        if !isNavigatedBack{
          Task {
            do {
              try await networkModel.fetchImages(search: "")
            } catch {
              print(error)
            }
          }
        }
      }
      .onDisappear {
        isNavigatedBack = true
      }
    }
  }
}

struct GridItemView: View {
  let item: String
  let media: String
  
  var body: some View {
    VStack {
      AsyncImage(url: URL(string: media)) { phase in
        switch phase  {
        case  .empty:
          ProgressView()
        case .success(let image):
          image
            .resizable()
            .frame(width: 120, height: 120, alignment: .leading)
            .aspectRatio(contentMode: .fit)
        case .failure(_):
          Text(" Failled to load mage" )
        @unknown default:
          EmptyView()
        }
      }
      .cornerRadius(5)
      
    }
    
  }
}

#Preview {
  ContentView()
}
