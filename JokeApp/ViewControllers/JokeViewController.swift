//
//  ViewController.swift
//  JokeApp
//
//  Created by Evgeni Glushko on 30.01.24.
//

import UIKit

//enum JokeFlag: CaseIterable {
//    case nsfw
//    case explicit
//    case political
//    case racist
//    case religious
//    case sexist
//}

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

//extension JokeViewController {
//    private func shouldFetchJoke(for settings: Settings, joke: Joke) -> Bool {
//        let flagsToCheck = JokeFlag.allCases
//
//        for flag in flagsToCheck {
//            switch flag {
//            case .nsfw where !settings.nsfw && joke.flags.nsfw,
//                 .explicit where !settings.explicit && joke.flags.explicit,
//                 .political where !settings.political && joke.flags.political,
//                 .racist where !settings.racist && joke.flags.racist,
//                 .religious where !settings.religious && joke.flags.religious,
//                 .sexist where !settings.sexist && joke.flags.sexist:
//                return true
//            default:
//                return false
//            }
//        }
//        
//        return false
//    }
//}

// MARK: - Networking
extension JokeViewController {
    private func fetchJoke() {
        let url = URL(string: "https://v2.jokeapi.dev/joke/Any")!
        networkManager.fetchJoke(from: url) { [unowned self] result in
            switch result {
            case .success(let joke):
                
                let settings = Settings.currentSettings
                
                if !settings.nsfw && joke.flags.nsfw {
                    return self.fetchJoke()
                }
                
                if !settings.explicit && joke.flags.explicit {
                    return self.fetchJoke()
                }
                
                if !settings.political && joke.flags.political {
                    return self.fetchJoke()
                }
                
                if !settings.racist && joke.flags.racist {
                    return self.fetchJoke()
                }
                
                if !settings.religious && joke.flags.religious {
                    return self.fetchJoke()
                }
                
                if !settings.sexist && joke.flags.sexist {
                    return self.fetchJoke()
                }
                
//                if !shouldFetchJoke(for: settings, joke: joke) {
//                    self.jokeLabel.text = "\(joke.joke ?? "")\(joke.setup ?? "") \n\n\(joke.delivery ?? "")"
//                }
                
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
