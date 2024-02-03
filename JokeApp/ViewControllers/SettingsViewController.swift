//
//  SettingsViewController.swift
//  JokeApp
//
//  Created by Evgeni Glushko on 3.02.24.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet var nsfw: UISwitch!
    @IBOutlet var religious: UISwitch!
    @IBOutlet var political: UISwitch!
    @IBOutlet var racist: UISwitch!
    @IBOutlet var sexist: UISwitch!
    @IBOutlet var explicit: UISwitch!
    
    private let settings = Settings.currentSettings
        
    override func viewDidLoad() {
        super.viewDidLoad()
        nsfw.isOn = settings.nsfw
        religious.isOn = settings.religious
        political.isOn = settings.political
        racist.isOn = settings.racist
        sexist.isOn = settings.sexist
        explicit.isOn = settings.explicit
    }
    
    @IBAction func cancelButton() {
        dismiss(animated: true)
    }
}
