//
//  Item.swift
//  Flickr_iOS_challenge
//
//  Created by Yashwant Rao on 19/02/24.
//

import Foundation


struct FlickerResponse: Codable {
    let items: [Item]
}


// MARK: - Item
struct Item: Codable, Identifiable, Hashable {
    
    
    let id = UUID()
    let title: String
    let link: URL
    let media: Media
    let published : String
    let authorID : String
    let tags : String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case published
        case authorID = "author_id"
        case tags
    }
    
    // Implement Hashable protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Implement Equatable protocol
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Media
struct Media: Codable {
    let m: String
}


let item = [
    Item(title: "Item1", link: URL(string: "item1")!, media: Media(m: "item1"), published: "Yes",authorID: "somexyz", tags: "some"),
    Item(title: "Item2", link: URL(string: "item2")!, media: Media(m: "item2"), published: "Yes",authorID: "123", tags: "somenew"),
]
