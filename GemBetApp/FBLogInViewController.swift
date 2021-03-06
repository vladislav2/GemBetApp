//
//  FBLogInViewController.swift
//  GemBetApp
//
//  Created by user on 18.03.2021.
//

import UIKit
import FBSDKLoginKit

class FBLogInViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let loginButton = FBLoginButton()
    loginButton.center = view.center
    loginButton.permissions = ["public_profile", "email"]
    loginButton.delegate = self
    view.addSubview(loginButton)
    
    if let token = AccessToken.current, !token.isExpired {
      let token = token.tokenString
      
      let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
      request.start { (connection, result, error) in
        print(result)
      }
    }
  }
}

extension FBLogInViewController: LoginButtonDelegate {
  func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
    let token = result?.token?.tokenString
    
    let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": ["email" ,"name"]], tokenString: token, version: nil, httpMethod: .get)
    request.start { (connection, result, error) in
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    
  }
}


// Swift // // Добавьте этот код в заголовок файла, например в ViewController.swift import FBSDKLoginKit // Добавьте этот код в тело класса ViewController: UIViewController { override func viewDidLoad() { super.viewDidLoad() let loginButton = FBLoginButton() loginButton.center = view.center view.addSubview(loginButton) } }
