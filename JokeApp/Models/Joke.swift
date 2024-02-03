//
//  Joke.swift
//  JokeApp
//
//  Created by Evgeni Glushko on 30.01.24.
//

struct Joke: Decodable {
    let category: String
    let type: String
    let setup: String?
    let delivery: String?
    let joke: String?
    let flags: Flags
    let safe: Bool
    let lang: String
    
    var getFlags: [String: Bool] {
        [
            "nsfw": flags.nsfw,
            "religious": flags.religious,
            "political": flags.political,
            "racist": flags.racist,
            "sexist": flags.sexist,
            "explicit": flags.explicit
        ]
    }
}

struct Flags: Decodable {
    let nsfw: Bool
    let religious: Bool
    let political: Bool
    let racist: Bool
    let sexist: Bool
    let explicit: Bool
}
