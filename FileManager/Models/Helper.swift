//
//  Helper.swift
//  FileManager
//
//  Created by Artem Karmaz on 3/22/19.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import Foundation

protocol Helper {
    func getCurrentTime() -> String
}

extension Helper {
    
    func getCurrentTime() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .long
        formatter.dateStyle = .none
        return formatter.string(from: currentDateTime)
    }
    
}
