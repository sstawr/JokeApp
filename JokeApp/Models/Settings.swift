//
//  Settings.swift
//  JokeApp
//
//  Created by Evgeni Glushko on 4.02.24.
//

import Foundation

struct Settings {
    let nsfw: Bool
    let religious: Bool
    let political: Bool
    let racist: Bool
    let sexist: Bool
    let explicit: Bool
    
    static var currentSettings: Settings {
        let dataStore = DataStore.shared
        
        return Settings(
            nsfw: dataStore.nsfw,
            religious: dataStore.religious,
            political: dataStore.political,
            racist: dataStore.racist,
            sexist: dataStore.sexist,
            explicit: dataStore.explicit
        )
    }
    
    static func updateSettings(nsfw: Bool, religious: Bool, political: Bool, racist: Bool, sexist: Bool, explicit: Bool) {
        let dataStore = DataStore.shared
        dataStore.nsfw = nsfw
        dataStore.religious = religious
        dataStore.political = political
        dataStore.racist = racist
        dataStore.sexist = sexist
        dataStore.explicit = explicit
    }
}
