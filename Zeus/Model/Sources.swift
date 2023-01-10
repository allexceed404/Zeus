//
//  Sources.swift
//  Zeus
//
//  Created by Priyanshu Verma on 09/01/23.
//

struct SourceInfo: Decodable {
    var id: String?
    var name: String?
    var description: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case url = "url"
        case category = "category"
        case language = "language"
        case country = "country"
    }
}

struct Sources: Decodable {
    var status: String?
    var sources: [SourceInfo]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case sources = "sources"
    }
}
