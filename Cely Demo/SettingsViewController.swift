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
        let result = Cely.logout()
        if case let .failure(error) = result {
            print(error)
        }
    }

    @IBAction func getCredentialsClicked(_: Any) {
        let result = Cely.credentials.get()
        switch result {
        case let .success(credentials):
            print(credentials)
        case let .failure(error):
            print("failed to get credentials")
            print(error)
        }
    }
}
