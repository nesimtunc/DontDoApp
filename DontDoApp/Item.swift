//
//  Item.swift
//  DontDoApp
//
//  Created by Nesim Tunç on 2023/06/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
