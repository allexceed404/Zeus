//
//  Networking.swift
//  Zeus
//
//  Created by Priyanshu Verma on 30/12/22.
//

import Foundation
import Network

enum UserError: Error {
    case invalidURL
    case NoDataAvailable
    case CanNotProcessData
    case NoInternetConnection
}

final class Networking {
    static let sharedInstance = Networking()
    let session = URLSession.shared
    let networkMonitor = NetworkMonitor.shared
    let newsAPIKey = "apiKey=\(Secrets.apiKey.rawValue)"
    
    let baseURL = "https://newsapi.org/v2/"
    
    func getNewsArticles(via endpoint: UtilityClass.APIEndpoint,
                         for categories: [String]?,
                         from sources: [String]?,
                         forCountry: String?,
                         in language: String?,
                         with keyword: String?,
                         searchIn: [String]?,
                         pageSize: Int,
                         pageNumber: Int,
                         completion: @escaping(Result<APIResult, UserError>) -> Void) {
        let url = urlStringBuilder(via: endpoint, for: categories, from: sources, forCountry: forCountry, in: language, with: keyword, searchIn: searchIn, pageSize: pageSize, pageNumber: pageNumber)
        print(url)
        
        guard let taskURL = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        let dataTask = session.dataTask(with: taskURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.NoDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(APIResult.self, from: jsonData)
                completion(.success(decodedResponse))
                return
            }
            catch {
                completion(.failure(.CanNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    func urlStringBuilder(via endpoint: UtilityClass.APIEndpoint,
                         for categories: [String]?,
                         from sources: [String]?,
                         forCountry: String?,
                         in language: String?,
                         with keyword: String?,
                         searchIn: [String]?,
                         pageSize: Int,
                         pageNumber: Int) -> String {
        var url = UtilityClass.newsBaseURL
        url.append(endpoint.rawValue)
        url.append("?")
        url.append(newsAPIKey)
        
        if(endpoint == .headlines) {
            if let categories = categories {
                for category in categories {
                    url.append("&category=\(category)")
                }
            }
        }
        
        if let sources = sources {
            for source in sources {
                url.append("&sources=\(source)")
            }
        }
        
        if let forCountry = forCountry {
            print(forCountry)
            if forCountry.count != 0 {
                if(endpoint == .everything) {
                    url.append("&q=\(forCountry)")
                } else if(endpoint == .headlines) {
                    if let countryCode = UtilityClass.countryCodeDict[forCountry] {
                        url.append("&country=\(countryCode)")
                    } else {
                        url.append("&q=\(forCountry)")
                    }
                }
            }
        }
        
        if let language = language {
            url.append("&language=\(language)")
        }
        
        if let keyword = keyword {
            if(endpoint == .everything) {
                if keyword.count != 0 {
                    url.append("&q=\(keyword)")
                }
            }
        }
        
        if let searchIn = searchIn {
            if(endpoint == .everything) {
                for this in searchIn {
                    url.append("&searchIn=\(this)")
                }
            }
        }
        
        url.append("&pageSize=\(pageSize)")
        url.append("&page=\(pageNumber)")
        
        url = url.replacingOccurrences(of: " ", with: "%20")
        
        return url
    }
    
    func getImage(urlString: String, completion: @escaping(Result<Data, UserError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        let imageTask = session.dataTask(with: imageURL) {data, _, _ in
            guard let image = data else {
                completion(.failure(.NoDataAvailable))
                return
            }
            completion(.success(image))
        }
        imageTask.resume()
    }
    
    func getSourceList(forCategory category: String? = nil, completion: @escaping(Result<Sources, UserError>) -> Void) {
        var url = UtilityClass.newsBaseURL
        url.append(UtilityClass.APIEndpoint.sources.rawValue)
        url.append("?")
        url.append(newsAPIKey)
        
        guard let category else {
            return
        }
        url.append("&category=\(category)")
        print(url)
        guard let taskURL = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        let dataTask = session.dataTask(with: taskURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.NoDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let sourceResponse = try decoder.decode(Sources.self, from: jsonData)
                completion(.success(sourceResponse))
                return
            }
            catch {
                completion(.failure(.CanNotProcessData))
            }
        }
        dataTask.resume()
    }
}
