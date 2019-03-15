//
//  Game End ViewController.swift
//  SoYouKnowFormula
//
//  Created by Elias Miller on 3/14/19.
//  Copyright © 2019 Summit Mobile Development. All rights reserved.
//

import UIKit

protocol GameEndViewControllerDelegate {
    func displayTime(time: Double)
}

class GameEndViewController: UIViewController {
    @IBOutlet var timeClock: UILabel!
    
    var delegate: GameEndViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("end call")
        // Do any additional setup after loading the view.
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
extension MemoryGameViewController: GameEndViewControllerDelegate {
    func displayTime(time: Double) {
        timerRunCount = time
    }
    
    
}
