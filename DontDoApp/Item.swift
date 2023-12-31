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
    var id: UUID
    var title: String
    var count: Int
    var timestamp: Date
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.count = 0
        self.timestamp = Date()
    }
}
