//
//  DetailsView.swift
//  Flickr_iOS_challenge
//
//  Created by Yashwant Rao on 19/02/24.
//

import SwiftUI

struct DetailsView: View {
    
    let currentItem: Item
    var body: some View {
        VStack(alignment: .leading, content: {
            AsyncImage(url: URL(string: currentItem.media.m), scale: 2.0){ phase in
                switch phase  {
                case  .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 300, maxHeight:400)
                    
                case .failure(_):
                    Text(" Failled to load mage" )
                @unknown default:
                    EmptyView()
                }
            }
            .padding()
            
            Text("Title: \(currentItem.title)").listRowSeparator(.hidden)
                .accessibility(label: Text("Title of current image is \(currentItem.title)"))
                .padding([.top, .bottom, .trailing], 8)
            
            Text("Author: \(currentItem.authorID)")
                .accessibility(label: Text("Title of current image is \(currentItem.authorID)"))
                .padding([.top, .bottom, .trailing], 8)
            
            Text("Published at: \(currentItem.published)")
                .accessibility(label: Text("Title of current image is \(currentItem.published)"))
                .padding([.top, .bottom, .trailing], 8)
            
            Text("Tags: \(!currentItem.tags.isEmpty ? currentItem.tags : "--")")
                .accessibility(label: Text("Title of current image is \(currentItem.tags)"))
                .padding([.top, .bottom, .trailing], 8)
            
        })
    }
}

#Preview {
    DetailsView(currentItem: item[0])
}
