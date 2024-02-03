//
//  ViewController.swift
//  JokeApp
//
//  Created by Evgeni Glushko on 30.01.24.
//

import UIKit

final class ViewController: UIViewController {
        
    @IBOutlet var jokeLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    private var settingsParam: [String : Bool] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as? SettingsViewController
        settingsVC?.nswfValue = settingsParam["nsfw"]
        settingsVC?.religiousValue = settingsParam["religious"]
        settingsVC?.politicalValue = settingsParam["political"]
        settingsVC?.racistValue = settingsParam["racist"]
        settingsVC?.sexistValue = settingsParam["sexist"]
        settingsVC?.explicitValue = settingsParam["explicit"]
    }
    
    @IBAction func getJoke() {
        fetchJoke()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        let settingsVC = segue.source as? SettingsViewController
        settingsParam["nsfw"] = settingsVC?.nsfw.isOn
        settingsParam["religious"] = settingsVC?.religious.isOn
        settingsParam["political"] = settingsVC?.political.isOn
        settingsParam["racist"] = settingsVC?.racist.isOn
        settingsParam["sexist"] = settingsVC?.sexist.isOn
        settingsParam["explicit"] = settingsVC?.explicit.isOn
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
    
    private func setupSettings() {
        settingsParam["nsfw"] = true
        settingsParam["religious"] = true
        settingsParam["political"] = true
        settingsParam["racist"] = true
        settingsParam["sexist"] = true
        settingsParam["explicit"] = true
    }
}

// MARK: - Networking
extension ViewController {
    private func fetchJoke() {
        let url = URL(string: "https://v2.jokeapi.dev/joke/Any")!
        networkManager.fetchJoke(from: url) { result in
            switch result {
            case .success(let joke):
                
                if self.settingsParam["nsfw"] == false && joke.flags.nsfw {
                    return self.fetchJoke()
                }
                
                if self.settingsParam["explicit"] == false && joke.flags.explicit {
                    return self.fetchJoke()
                }
                
                if self.settingsParam["political"] == false && joke.flags.political {
                    return self.fetchJoke()
                }
                
                if self.settingsParam["racist"] == false && joke.flags.racist {
                    return self.fetchJoke()
                }
                
                if self.settingsParam["religious"] == false && joke.flags.religious {
                    return self.fetchJoke()
                }
                
                if self.settingsParam["sexist"] == false && joke.flags.sexist {
                    return self.fetchJoke()
                }
            
                self.jokeLabel.text = "\(joke.joke ?? "")\(joke.setup ?? "") \n\n\(joke.delivery ?? "")"
                
            case .failure(let error):
                print(error)
                self.showAlert(with: "Failed", and: "You can see error in the Debug area")
            }
        }
    }
}
