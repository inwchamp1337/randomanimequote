//
//  QuoteResponse.swift
//  randomquote
//
//  Created by Csy on 18/2/2568 BE.
//


import Foundation

struct QuoteResponse: Codable {
    let status: String
    let data: QuoteData
}

struct QuoteData: Codable {
    let content: String
    let anime: Anime
    let character: Character
}

struct Anime: Codable {
    let id: Int
    let name: String
    let altName: String?
}

struct Character: Codable {
    let id: Int
    let name: String
}
