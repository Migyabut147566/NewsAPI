//
//  NewsViewModel.swift
//  NewsAPI
//
//  Created by Migy Yabut on 7/31/21.
//

import Foundation
import UIKit

final class NewsViewModel {
    static let NewsAPI = NewsViewModel()
    
    //Target Countries: US | CA
    //APIkey: 31f10cba18a14ef9a1af5424c1e18da0
    
    struct Repository {
        static let unitedStatesArticles = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=31f10cba18a14ef9a1af5424c1e18da0")
        static let canadaArticles = URL(string: "https://newsapi.org/v2/top-headlines?country=ca&apiKey=31f10cba18a14ef9a1af5424c1e18da0")
    }
    private init() {}
    public func newsDisplayUS(completion: @escaping (Result<[Properties], Error>) -> Void) {
        guard let url = Repository.unitedStatesArticles else {
            return
        }
        let news = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if
                let data = data {
                do {
                    let result = try JSONDecoder().decode(APIStructure.self, from: data)
                    print("Test: \(result.articles.count)")
                    completion(.success(result.articles))
                    }
                catch {
                    completion(.failure(error))
                    }
                }
            }
        news.resume()
    }
    public func newsDisplayCA(completion: @escaping (Result<[Properties], Error>) -> Void) {
        guard let url = Repository.canadaArticles else {
            return
        }
        let news = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if
                let data = data {
                do {
                    let result = try JSONDecoder().decode(APIStructure.self, from: data)
                    print("Test: \(result.articles.count)")
                    completion(.success(result.articles))
                    }
                catch {
                    completion(.failure(error))
                    }
                }
            }
        news.resume()
    }
    
}

class NewsTVCViewModel {
    let header: String
    let title: String
    let detail: String
    
    init(header: String, title: String, detail: String) {
        self.header = header
        self.title = title
        self.detail = detail
    }
}
