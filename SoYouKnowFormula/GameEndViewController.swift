//
//  Game End ViewController.swift
//  SoYouKnowFormula
//
//  Created by Elias Miller on 3/14/19.
//  Copyright © 2019 Summit Mobile Development. All rights reserved.
//

import UIKit


protocol TimerDelegate: class {
    func printTime(timerRunCount: Double)
}
class GameEndViewController: UIViewController {
    @IBOutlet var scoreboard: UILabel!
    
    weak var delegate: TimerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("end call")
        // Do any additional setup after loading the view.
    
    //delegate?.printTime(timerRunCount: <#T##Double#>)
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
