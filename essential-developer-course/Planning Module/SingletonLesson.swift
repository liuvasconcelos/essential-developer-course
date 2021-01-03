//
//  SingletonLesson.swift
//  essential-developer-course
//
//  Created by Livia Vasconcelos on 03/01/21.
//

/**
 Go to Playground to run it properly.
*/
import UIKit

struct LoggedInUser {}

class ApiClient {
    static let instance = ApiClient()
}

extension ApiClient {
    func login(completion: (LoggedInUser) -> Void) {
        print("hoy")
        completion(LoggedInUser())
    }
}

class MockApiClient {
    func login(completion: (LoggedInUser) -> Void) {
        print("test")
        completion(LoggedInUser())
    }
}

class LoginViewModel {
    var login: (((LoggedInUser) -> Void) -> Void)?
    func didTapLoginButton() {
        login? { user in
           print("Hey")
        }
    }
}

/**
 Execution
*/
//let vm = LoginViewModel()
//vm.login = ApiClient.instance.login(completion:)
//vm.login = MockApiClient().login(completion:)
//vm.didTapLoginButton()

