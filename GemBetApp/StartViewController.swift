//
//  StartViewController.swift
//  GemBetApp
//
//  Created by user on 16.03.2021.
//

import UIKit
import FBSDKLoginKit

class StartViewController: UIViewController {
  
  private let notificatios = Notifications()
  private let notificationTitle = "Go to play, regular everyday normal motherfucker"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    checkLoggedIn()
  }
  
  /*
   Еще нету динамических ссылок и яндекс метрики, с ними не имел дела, но разберусь
   Local Push notifications тоже не делал, может успею до того как посмотрите)
   */
  
  private func showAlertController() {
    let alertController = UIAlertController(title: "Who you are?", message: nil, preferredStyle: .actionSheet)
    let iAmModerAction = UIAlertAction(title: "I am moderator", style: .default) { (_) in
      self.performSegue(withIdentifier: "openGame", sender: nil)
    }
    let iAmPlayerAction = UIAlertAction(title: "I am player", style: .default) { (_) in
      self.performSegue(withIdentifier: "openURL", sender: nil)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(iAmModerAction)
    alertController.addAction(iAmPlayerAction)
    alertController.addAction(cancelAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  @IBAction func startButtonPressed() {
    showAlertController()
  }
  
  @IBAction func getNotifiButton() {
    notificatios.scheduleNotification(notificationTitle: notificationTitle)
  }
  
}

extension StartViewController {
  private func checkLoggedIn() {
    if let token = AccessToken.current, !token.isExpired {
      
    } else {
      DispatchQueue.main.async {
        let storiboard = UIStoryboard(name: "Main", bundle: nil)
        guard let fbLogInViewController = storiboard.instantiateViewController(withIdentifier: "fbLogInVC") as? FBLogInViewController else { return }
        self.present(fbLogInViewController, animated: true, completion: nil)
        return
      }
    }
  }
}
