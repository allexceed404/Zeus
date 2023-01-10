//
//  APIResult.swift
//  Zeus
//
//  Created by Priyanshu Verma on 30/12/22.
//

struct APIResult: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Articles]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}
