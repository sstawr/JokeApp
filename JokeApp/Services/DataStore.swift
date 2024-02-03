//
//  DataStore.swift
//  JokeApp
//
//  Created by Evgeni Glushko on 4.02.24.
//

import Foundation

final class DataStore {
    static let shared = DataStore()
    
    var nsfw = true
    var religious = true
    var political = true
    var racist = true
    var sexist = true
    var explicit = true
    
    private init() {}
}
