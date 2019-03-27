//
//  ServiceProvider.swift
//  TopShelf
//
//  Created by Elias Miller on 3/26/19.
//  Copyright © 2019 Summit Mobile Development. All rights reserved.
//

import Foundation
import TVServices

class ServiceProvider: NSObject, TVTopShelfProvider {

    override init() {
        super.init()
    }

    // MARK: - TVTopShelfProvider protocol

    var topShelfStyle: TVTopShelfContentStyle {
        // Return desired Top Shelf style.
        return .inset
    }

    var topShelfItems: [TVContentItem] {
        // Create an array of TVContentItems.
        var pics = [TVContentItem]()
        
        for i in 1 ... 3 {
            let uid = UUID().uuidString
            
            let identifier = TVContentIdentifier(identifier: uid, container: nil)
            let item = TVContentItem(contentIdentifier: identifier)
            var screen = "screen" + String(i)
            print("lets make sure\(screen)")
            
            item.setImageURL(Bundle.main.url(forResource: screen, withExtension: "jpg"), forTraits: .userInterfaceStyleLight)
            item.setImageURL(Bundle.main.url(forResource: screen, withExtension: "jpg"), forTraits: .userInterfaceStyleDark)
            
            item.displayURL = URL(string: "soyouknowformula://display/\(uid)")
            item.playURL = URL(string: "soyouknowformula://play/\(uid)")
            pics.append(item)
            
        }
        
        print(pics)
        return pics
    }

}

