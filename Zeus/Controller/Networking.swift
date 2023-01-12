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
    
    let baseURL = "https://newsapi.org/v2/"
    
//    func activeInternetConnectivity() -> Bool {
//        if NetworkMonitor.shared.startMonitoring() == .satisfied {
//            NetworkMonitor.shared.stopMonitoring()
//            return true
//        } else {
//            NetworkMonitor.shared.stopMonitoring()
//            return false
//        }
//    }
    
    func getNews(query: String, completion: @escaping(Result<APIResult, UserError>) -> Void) {
//        if !activeInternetConnectivity() {
//            completion(.failure(.NoInternetConnection))
//            return
//        }
        if !networkMonitor.checkForNetworkConnectivity() {
            completion(.failure(.NoInternetConnection))
            return
        }
        print(query)
        guard let taskURL = URL(string: baseURL+query) else {
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
                let newsResponse = try decoder.decode(APIResult.self, from: jsonData)
                completion(.success(newsResponse))
                return
            }
            catch {
                completion(.failure(.CanNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    func getImage(urlString: String, completion: @escaping(Result<Data, UserError>) -> Void) {
//        if !activeInternetConnectivity() {
//            completion(.failure(.NoInternetConnection))
//            return
//        }
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
    
    func getSources(forCategory category: String, completion: @escaping(Result<Sources, UserError>) -> Void) {
        let apiEndpoint = "https://newsapi.org/v2/top-headlines/sources?apiKey=\(Secrets.apiKey.rawValue)&category=\(category)"
        print(apiEndpoint)
        guard let taskURL = URL(string: apiEndpoint) else {
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
