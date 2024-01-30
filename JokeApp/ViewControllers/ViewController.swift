//
//  ViewController.swift
//  JokeApp
//
//  Created by Evgeni Glushko on 30.01.24.
//

import UIKit

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class ViewController: UIViewController {
    
    private let link = URL(string: "https://v2.jokeapi.dev/joke/Any?safe-mode")!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJoke();
    }
    
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Networking
extension ViewController {
    private func fetchJoke() {
        URLSession.shared.dataTask(with: link) { [weak self] data, _, error in
            guard let self else { return }
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let joke = try JSONDecoder().decode(Joke.self, from: data)
                print(joke)
                DispatchQueue.main.async {
                    self.showAlert(withStatus: .success)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.showAlert(withStatus: .failed)
                }
            }
            
        }.resume()
    }
}
