//
//  GameViewController.swift
//  GemBetApp
//
//  Created by user on 17.03.2021.
//

import UIKit

class GameViewController: UIViewController {
  
  @IBOutlet weak var firstLabel: UILabel!
  @IBOutlet weak var secondLabel: UILabel!
  @IBOutlet weak var thirdLabel: UILabel!
  @IBOutlet weak var pointsLabel: UILabel!
  
  @IBOutlet weak var playButton: UIButton!
  
  private var firstTimer = Timer()
  private var secondTimer = Timer()
  private var thirdTimer = Timer()
  private var stopTimer = Timer()
  private var time = 0
  
  private var points = 100 {
    didSet {
      pointsLabel.text = "Очки: \(points)"
    }
  }
  private var valueFirstLabel = 0 {
    didSet {
      firstLabel.text = String(valueFirstLabel)
    }
  }
  private var valueSecondLabel = 0 {
    didSet {
      secondLabel.text = String(valueSecondLabel)
    }
  }
  private var valueThirdLabel = 0 {
    didSet {
      thirdLabel.text = String(valueThirdLabel)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pointsLabel.text = "Очки: \(points)"
  }
  
  private func createAndStartTimer() {
    playButton.isEnabled = false
    firstTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(editFirstValue), userInfo: nil, repeats: true)
    secondTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(editSecontValue), userInfo: nil, repeats: true)
    thirdTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(editThirdValue), userInfo: nil, repeats: true)
    stopTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(whenStopTimers), userInfo: nil, repeats: true)
  }
  
  private func scoring() {
    if valueFirstLabel == valueSecondLabel && valueSecondLabel == valueThirdLabel {
      points += 1000
      return
    }
    if valueThirdLabel == valueSecondLabel || valueThirdLabel == valueFirstLabel || valueSecondLabel == valueFirstLabel {
      points += 50
      return
    }
  }
  
  // MARK: - Selectors
  
  @objc private func editFirstValue() {
    valueFirstLabel = Int.random(in: 0..<6)
  }
  @objc private func editSecontValue() {
    valueSecondLabel = Int.random(in: 0..<6)
  }
  @objc private func editThirdValue() {
    valueThirdLabel = Int.random(in: 0..<6)
  }
  
  @objc private func whenStopTimers() {
    time += 1
    if time == 2 { firstTimer.invalidate() }
    if time == 3 { secondTimer.invalidate() }
    if time == 4 {
      thirdTimer.invalidate()
      stopTimer.invalidate()
      time = 0
      scoring()
      playButton.isEnabled = true
    }
  }
  @IBAction func playButtonPressed() {
    points -= 10
    createAndStartTimer()
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
