//
//  Channel.swift
//  shyStudent
//
//  Created by Jaewon Kim on 2017-08-21.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//
import Foundation

class Channel: NSObject {

    internal let id: String
    internal let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    static func ==(lhs: Channel, rhs: Channel) -> Bool {
        return lhs.id == rhs.id
    }
}
