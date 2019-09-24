//
//  SettingsViewController.swift
//  Cely
//
//  Created by Fabian Buentello on 10/15/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Cely
import UIKit

class SettingsViewController: UIViewController {
    @IBAction func LogoutButtonPressed() {
        Cely.logout()
    }
}
