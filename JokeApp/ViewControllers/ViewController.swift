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

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    
    @IBAction func getJoke() {
        fetchJoke()
    }
    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Networking
extension ViewController {
    private func fetchJoke() {
        let url = URL(string: "https://v2.jokeapi.dev/joke/Any")!
        networkManager.fetchJoke(from: url) { result in
            switch result {
            case .success(let joke):
                self.jokeLabel.text = "\(joke.joke ?? "")\(joke.setup ?? "") \n\n\(joke.delivery ?? "")"
            case .failure(let error):
                print(error)
                self.showAlert(with: "Failed", and: "You can see error in the Debug area")
            }
        }
    }
}
