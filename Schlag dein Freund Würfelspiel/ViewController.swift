//
//  ViewController.swift
//  Schlag dein Freund Würfelspiel
//
//  Created by Murat Gültürk on 09.03.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblPlayer1Score: UILabel!
    @IBOutlet weak var lblPlayer2Score: UILabel!
    @IBOutlet weak var lblPlayer1Point: UILabel!
    @IBOutlet weak var lblPlayer2Point: UILabel!
    @IBOutlet weak var imgPlayer1Status: UIImageView!
    @IBOutlet weak var imgPlayer2Status: UIImageView!
    @IBOutlet weak var imgDice1: UIImageView!
    @IBOutlet weak var imgDice2: UIImageView!
    @IBOutlet weak var lblResult: UILabel!

    var playerPoints = (firstPlayerPoint : 0, secondPlayerPoint : 0)
    var playerScors = (firstPlayerScor : 0, secondPlayerScor : 0)
    var playerTurn : Int = 1
    var maxLevelAnzahl : Int = 5
    var currentLevel : Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // hier die inhalte beim App start angezeigt
        // Background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "arkaPlan")!)

    }

    // Device Shake
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

        if currentLevel > maxLevelAnzahl{
            return
        }

        generateDiceValues()

    }

    // Dice values assign
    func Result(dice1 : Int, dice2 : Int){

        if playerTurn == 1{
            playerPoints.firstPlayerPoint = dice1 + dice2
            lblPlayer1Point.text = String(playerPoints.firstPlayerPoint)
            imgPlayer1Status.image = UIImage(named: "bekle")
            imgPlayer2Status.image = UIImage(named: "onay")
            lblResult.text = "2. Spieler dran!"
            playerTurn = 2

            // new level begins
            lblPlayer2Point.text = "0"
        }else{
            playerPoints.secondPlayerPoint = dice1 + dice2
            lblPlayer2Point.text = String(playerPoints.firstPlayerPoint)
            imgPlayer2Status.image = UIImage(named: "onay")
            imgPlayer1Status.image = UIImage(named: "bekle")
            lblResult.text = "1. Spieler dran!"
            playerTurn = 1

            // new level begins
            lblPlayer1Point.text = "0"

            // level will to end
            if playerPoints.firstPlayerPoint > playerPoints.secondPlayerPoint{

                // Player 1 won the Game
                playerScors.firstPlayerScor += 1
                lblResult.text = "Erste Spieler gewinnt Level \(currentLevel)"
                currentLevel += 1
                lblPlayer1Score.text = String(playerScors.firstPlayerScor)

                // Player 2 won the Game
            }else if playerScors.secondPlayerScor > playerScors.firstPlayerScor{

                playerScors.secondPlayerScor += 1
                lblResult.text = "Zweite Spieler gewinnt Level \(currentLevel)"
                currentLevel += 1
                lblPlayer2Score.text = String(playerScors.secondPlayerScor)

                // Game draw
            }else{

                lblResult.text = "Level \(currentLevel) unentschieden !"

            }
        }
    }

    // rondom generate Dice Values
    func generateDiceValues(){

        // Multi Thread
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
            let dice1 = arc4random_uniform(6) + 1
            let dice2 = arc4random_uniform(6) + 1

            self.imgDice1.image = UIImage(named: String(dice1))
            self.imgDice2.image = UIImage(named: String(dice2))

            self.Result(dice1: Int(dice1), dice2: Int(dice2))

            // Game Over
            if self.currentLevel > self.maxLevelAnzahl{
                if self.playerScors.firstPlayerScor > self.playerScors.secondPlayerScor{
                    self.lblResult.text = "GAME OVER!\nErste Spieler hat gewonnen!"
                }else{
                    self.lblResult.text = "GAME OVER!\nZweite Spieler hat gewonnen!"
                }
            }
        }
        lblResult.text = "Würfeln für den \(playerTurn). Spieler"
        imgDice1.image = UIImage(named: "bilinmeyenZar")
        imgDice2.image = UIImage(named: "bilinmeyenZar")
    }

}

