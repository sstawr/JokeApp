//
//  NetworkManager.swift
//  JokeApp
//
//  Created by Evgeni Glushko on 3.02.24.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchJoke(from url: URL, completion: @escaping(Result<Joke, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let joke = Joke.getJoke(from: value)
                    completion(.success(joke))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
