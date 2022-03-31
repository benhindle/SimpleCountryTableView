//
//  Extensions.swift
//  BenHindleFSTest
//
//  Created by Ben Hindle on 1/4/2022.
//

import Foundation

extension String {
    func capitalizeFirst() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirst() {
        self = self.capitalizeFirst()
    }
}

