//
//  Color.swift
//  DragAndDropWithColors
//
//  Created by Jp LaFond on 10/11/17.
//  Copyright © 2017 Jp LaFond. All rights reserved.
//

import Foundation
import UIKit

/// Color model
enum Color: String {
    // Standard colors
    case red, orange, yellow, green, blue, purple
    // Generic insert case
    case gray

    var color: UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .orange:
            return UIColor.orange
        case .yellow:
            return UIColor.yellow
        case .green:
            return UIColor.green
        case .blue:
            return UIColor.blue
        case .purple:
            return UIColor.purple

        case .gray:
            return UIColor.lightGray
        }
    }

    static var allColors: [Color] = {
        return [.red, .orange, .yellow, .green, .blue, .purple]
    }()
}

extension Color: CustomStringConvertible {
    var description: String {
        return self.rawValue.capitalized
    }
}
