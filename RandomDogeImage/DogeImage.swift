//
//  DogeImage.swift
//  RandomDogeImage
//
//  Created by Александр Пронин on 27.11.2021.
//

struct DogeImage: Decodable {
    let url: String
}

struct CatImage: Decodable {
    let file: String
}

struct FoxImage: Decodable {
    let image: String
}
