//
//  BiometricLoginViewController.swift
//  Cely Demo
//
//  Created by Fabian Buentello on 10/5/19.
//  Copyright © 2019 Fabian Buentello. All rights reserved.
//

import Cely
import UIKit

class BiometricLoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameField: UITextField?
    @IBOutlet weak var passwordField: UITextField?

    @IBOutlet var textFields: [UITextField]?

    var credentialsExist = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let credentialsResult = Cely.credentials.get()
        if case let .success(creds) = credentialsResult {
            print(creds)
            credentialsExist = true
            usernameField?.text = creds.username
            passwordField?.text = creds.password
            loginButtonPressed()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameField?.delegate = self
        passwordField?.delegate = self
    }

    @IBAction func loginButtonPressed() {
        if let username = usernameField?.text, let password = passwordField?.text {
            let tokenResult = User.save("FAKETOKEN:\(username)\(password)", as: .token)
            if case let .failure(error) = tokenResult {
                return print("tokenResult Error: \(error)")
            }

            if !credentialsExist {
                let credentialResult = Cely.credentials.set(
                    username: username,
                    password: password,
                    server: "api.example.com",
                    options: [.biometricsIfPossible]
                )

                if case let .failure(error) = credentialResult {
                    return print("Cely store credentials error: \(error)")
                }
            }

            Cely.changeStatus(to: .loggedIn)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let next = textFields?.filter({ $0.tag == nextTag }).first {
            next.becomeFirstResponder()
            return true
        }

        textField.resignFirstResponder()
        return true
    }
}
