//
//  MemoryGameViewController.swift
//  SoYouKnowFormula
//
//  Created by Elias Miller on 3/12/19.
//  Copyright © 2019 Summit Mobile Development. All rights reserved.
//

import UIKit

class MemoryGameViewController: UICollectionViewController {

    var names: [JSON]!
    var cells = [Int: DriverCardCell]()
    
    var language = "english"
    var nameType = ""
    
    var firstCardSelected: DriverCardCell?
    var secondCardSelected: DriverCardCell?
   
    var numberCorrect = 0
    var timerRunCount = 0.0
    var timer = Timer()
    
    
    
    
    @objc func startTimer() {
        print("Timer is on")
        timer.fire()
        //timerRunCount += 0.01
        print("This is the timer clock \(timerRunCount)")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: Selector(startTimer), userInfo: nil, repeats: false)
        
        
        guard let namesPath = Bundle.main.url(forResource: nameType, withExtension: "json") else {return}
        guard let contents = try? Data(contentsOf: namesPath) else {return}
        names = JSON(contents).arrayValue
        //print(names)
        // Do any additional setup after loading the view.
        
        //Creating array that contains the 28 cells, numbering accordingly and shuffle
        var cardCellNumbers = Array(0..<28)
        cardCellNumbers.shuffle()
        
        //shuffle and loop through first half of cells(14)
        for i in 0 ..< 14 {
            //Need to get two numbers, one for picture and one for name
            let picNumber = cardCellNumbers.removeLast()
            let nameNumber = cardCellNumbers.removeLast()
            
            //Now create index path for numbers
            let picIndexPath = IndexPath(item: picNumber, section: 0)
            let nameIndexPath = IndexPath(item: nameNumber, section: 0)
            
            guard let picCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: picIndexPath) as? DriverCardCell else {return}
            guard let nameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: nameIndexPath) as? DriverCardCell else {return}
            
            //Give cell correct name
            
            nameCell.name = names[i]["english"].stringValue
            nameCell.textLabel.text = names[i][language].stringValue
            //print("let us see what \(nameCell.name) is")
            //print("let us see what \(nameCell.textLabel.text) is")
            
            //Give second cell the same word along with correct image
            picCell.name = nameCell.name
            picCell.content.image = UIImage(named: picCell.name)
            
            cells[picNumber] = picCell
            cells[nameNumber] = nameCell
            //print("is empty dictionary adding \(cells[picNumber]) and \(cells[nameNumber])")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        timer.fire()
        print("ok is the time valid\(timer.timeInterval)")
        return 28
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        //print("ok whats here\(String(describing: cells[indexPath.row]))")
        
        return cells[indexPath.row]!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? DriverCardCell else {return}
        
        
        
        if firstCardSelected == nil {
            firstCardSelected = cell
            
        } else if secondCardSelected == nil && cell != firstCardSelected {
            secondCardSelected = cell
            
            //stop selecting cards
            view.isUserInteractionEnabled = false
            //Check answer
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                self.checkForMatch()
            }
        } else {
            //Exit
            return
        }
        cell.flip(to: "cardFrontBlank", hideContents: false)
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DriverCardCell else {return false}
        return !cell.name.isEmpty
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if let previous = context.previouslyFocusedView {
                previous.transform = .identity
            }
            
            if let next = context.nextFocusedView {
                next.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
        })
    }
    
    func checkForMatch() {
        guard let firstCard = firstCardSelected,
            let secondCard = secondCardSelected else {return}
        
        if firstCard.name == secondCard.name {
            //Clear them so they cant be used again
            firstCard.name = ""
            secondCard.name = ""
            
            //Want to add border color here
//            firstCard.layer.borderColor = UIColor(red: 250, green: 250, blue: 210, alpha: 1) as! CGColor
//            secondCard.layer.borderColor = UIColor(red: 250, green: 250, blue: 210, alpha: 1) as! CGColor
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIView.transition(with: firstCard.card, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                    firstCard.card.layer.borderColor = UIColor(red: 57, green: 255, blue: 20, alpha: 1) as! CGColor
                })
                
                UIView.transition(with: secondCard.card, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                    secondCard.card.layer.borderColor = UIColor(red: 57, green: 255, blue: 20, alpha: 1) as! CGColor
                })
                
                //Add to score
                self.numberCorrect += 1
                print("this is number correct so far\(self.numberCorrect)")
                
                if self.numberCorrect == 1 {
                    self.endGame()
                }
                
            }
        } else {
            firstCard.flip(to: "CarCardCellBack", hideContents: true)
            secondCard.flip(to: "CarCardCellBack", hideContents: true)
        }
        
        firstCardSelected = nil
        secondCardSelected = nil
        view.isUserInteractionEnabled = true
        
    }
    
    
//    @objc func startTimer() {
//        print("Timer is on")
//        timerRunCount += Int(0.01)
//        print("This is the timer clock \(timerRunCount)")
//    }
    
//    func startTime() {
//        timer.fire()
//    }
    
    
    func endGame() {
        print("This is your final time \(timer.timeInterval)")
        timer.invalidate()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
