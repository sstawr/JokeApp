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
    
    init(
        category: String,
        type: String,
        setup: String?,
        delivery: String?,
        joke: String?,
        flags: Flags,
        safe: Bool,
        lang: String
    ) {
        self.category = category
        self.type = type
        self.setup = setup
        self.delivery = delivery
        self.joke = joke
        self.flags = flags
        self.safe = safe
        self.lang = lang
    }
    
    init(jokeDetails: [String: Any]) {
        category = jokeDetails["category"] as? String ?? ""
        type = jokeDetails["type"] as? String ?? ""
        setup = jokeDetails["setup"] as? String
        delivery = jokeDetails["delivery"] as? String
        joke = jokeDetails["joke"] as? String
        flags = Flags(jokeDetailsFlags: jokeDetails)
        safe = jokeDetails["safe"] as? Bool ?? false
        lang = jokeDetails["lang"] as? String ?? ""
    }
    
    static func getJoke(from value: Any) -> Joke {
        guard let jokeDetails = value as? [String: Any] else {
            return Joke(
                category: "",
                type: "",
                setup: "",
                delivery: "",
                joke: "",
                flags: Flags(
                    nsfw: true,
                    religious: true,
                    political: true,
                    racist: true,
                    sexist: true,
                    explicit: true
                ),
                safe: false,
                lang: ""
            )
        }
        return Joke(jokeDetails: jokeDetails)
    }
}

struct Flags: Decodable {
    let nsfw: Bool
    let religious: Bool
    let political: Bool
    let racist: Bool
    let sexist: Bool
    let explicit: Bool
    
    init(
        nsfw: Bool,
        religious: Bool,
        political: Bool,
        racist: Bool,
        sexist: Bool,
        explicit: Bool
    ) {
        self.nsfw = nsfw
        self.religious = religious
        self.political = political
        self.racist = racist
        self.sexist = sexist
        self.explicit = explicit
    }
    
    init(jokeDetailsFlags: [String: Any]) {
        nsfw = jokeDetailsFlags["nsfw"] as? Bool ?? false
        religious = jokeDetailsFlags["religious"] as? Bool ?? false
        political = jokeDetailsFlags["political"] as? Bool ?? false
        racist = jokeDetailsFlags["racist"] as? Bool ?? false
        sexist = jokeDetailsFlags["sexist"] as? Bool ?? false
        explicit = jokeDetailsFlags["explicit"] as? Bool ?? false
    }
}
