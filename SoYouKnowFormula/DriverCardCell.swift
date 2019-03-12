//
//  DriverCardCell.swift
//  SoYouKnowFormula
//
//  Created by Elias Miller on 3/10/19.
//  Copyright © 2019 Summit Mobile Development. All rights reserved.
//

import UIKit

class DriverCardCell: UICollectionViewCell {
    @IBOutlet var card: UIImageView!
    @IBOutlet var content: UIImageView!
    @IBOutlet var textLabel: UILabel!
    
    var name = "?"
    
    func flip(to image: String, hideContents: Bool) {
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.card.image = UIImage(named: image)
            self.content.isHidden = hideContents
            self.textLabel.isHidden = hideContents
        })
    }
}
