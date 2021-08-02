//
//  NewsModel.swift
//  NewsAPI
//
//  Created by Migy Yabut on 7/31/21.
//

import Foundation

//Article, Author, Published Date
struct APIStructure: Codable {
    let articles: [Properties]
}
struct Properties: Codable {
    let author: String?
    let title: String
    let publishedAt: String
    let url: String
}
