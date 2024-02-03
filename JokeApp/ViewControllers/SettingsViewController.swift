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
    
    var nswfValue: Bool!
    var religiousValue: Bool!
    var politicalValue: Bool!
    var racistValue: Bool!
    var sexistValue: Bool!
    var explicitValue: Bool!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        nsfw.isOn = nswfValue
        religious.isOn = religiousValue
        political.isOn = politicalValue
        racist.isOn = racistValue
        sexist.isOn = sexistValue
        explicit.isOn = explicitValue
    }
    
    @IBAction func cancelButton() {
        dismiss(animated: true)
    }
}
