//
//  ViewController.swift
//  JokeApp
//
//  Created by Evgeni Glushko on 30.01.24.
//

import UIKit

enum JokeFlags: CaseIterable {
    case nsfw
    case explicit 
    case political
    case racist
    case religious
    case sexist
}

extension JokeFlags {
    func shouldFetchJoke(for settings: Settings, flags: Flags) -> Bool {
        switch self {
        case .nsfw: return !settings.nsfw && flags.nsfw
        case .explicit: return !settings.explicit && flags.explicit
        case .political: return !settings.political && flags.political
        case .racist: return !settings.racist && flags.racist
        case .religious: return !settings.religious && flags.religious
        case .sexist: return !settings.sexist && flags.sexist
        }
    }
}


final class JokeViewController: UIViewController {
        
    @IBOutlet var jokeLabel: UILabel!
    private let networkManager = NetworkManager.shared
    
    @IBAction func getJoke() {
        fetchJoke()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        let settingsVC = segue.source as? SettingsViewController
        Settings.updateSettings(
            nsfw: settingsVC?.nsfw.isOn ?? true,
            religious: settingsVC?.religious.isOn ?? true,
            political: settingsVC?.political.isOn ?? true,
            racist: settingsVC?.racist.isOn ?? true,
            sexist: settingsVC?.sexist.isOn ?? true,
            explicit: settingsVC?.explicit.isOn ?? true
        )
    }

    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Networking
extension JokeViewController {
    private func fetchJoke() {
        let url = URL(string: "https://v2.jokeapi.dev/joke/Any")!
        networkManager.fetchJoke(from: url) { [unowned self] result in
            switch result {
            case .success(let joke):
                
                let settings = Settings.currentSettings
                let flagsToCheck = JokeFlags.allCases
                
                print(joke)
                
                for flag in flagsToCheck {
                    if flag.shouldFetchJoke(for: settings, flags: joke.flags) {
                        return self.fetchJoke()
                    }
                }
                
//                if !settings.nsfw && joke.flags.nsfw {
//                    return self.fetchJoke()
//                }
//                
//                if !settings.explicit && joke.flags.explicit {
//                    return self.fetchJoke()
//                }
//                
//                if !settings.political && joke.flags.political {
//                    return self.fetchJoke()
//                }
//                
//                if !settings.racist && joke.flags.racist {
//                    return self.fetchJoke()
//                }
//                
//                if !settings.religious && joke.flags.religious {
//                    return self.fetchJoke()
//                }
//                
//                if !settings.sexist && joke.flags.sexist {
//                    return self.fetchJoke()
//                }
//
                self.jokeLabel.text = "\(joke.joke ?? "")\(joke.setup ?? "") \n\n\(joke.delivery ?? "")"
                
                print("""
                
                    nsfw = \(joke.flags.nsfw)
                    explicit = \(joke.flags.explicit)
                    political = \(joke.flags.political)
                    racist = \(joke.flags.racist)
                    religious = \(joke.flags.religious)
                    sexist = \(joke.flags.sexist)
                
                """)
                
            case .failure(let error):
                print(error)
                self.showAlert(with: "Failed", and: "You can see error in the Debug area")
            }
        }
    }
}
