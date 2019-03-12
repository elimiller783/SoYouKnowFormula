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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let namesPath = Bundle.main.url(forResource: nameType, withExtension: "json") else {return}
        guard let contents = try? Data(contentsOf: namesPath) else {return}
        names = JSON(contents).arrayValue
        print(names)
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
            print("let us see what \(nameCell.name) is")
            print("let us see what \(nameCell.textLabel.text) is")
            
            //Give second cell the same word along with correct image
            picCell.name = nameCell.name
            picCell.content.image = UIImage(named: picCell.name)
            
            cells[picNumber] = picCell
            cells[nameNumber] = nameCell
            print("is empty dictionary adding \(cells[picNumber]) and \(cells[nameNumber])")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        print("ok whats here\(String(describing: cells[indexPath.row]))")
        
        return cells[indexPath.row]!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DriverCardCell else {return}
        
        print("I need to know dammnit\(cell.name)")
        
        cell.flip(to: "cardFrontBlank", hideContents: false)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
