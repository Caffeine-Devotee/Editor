//
//  Constant.swift
//  Editor
//
//  Created by GAURAV NAYAK on 15/06/20.
//  Copyright © 2020 CaffeineDevotee. All rights reserved.
//

import Foundation
import UIKit

enum TextFormat {
    case Heading_1
    case Heading_2
    case Heading_3
    case Description
}

let formatCase_1 = [TextFormat.Description, TextFormat.Heading_1, TextFormat.Heading_3]
let formatCase_2 = [TextFormat.Description, TextFormat.Heading_2, TextFormat.Heading_3]


func getTextAttribute(type : TextFormat) -> [NSAttributedString.Key : Any] {
    switch type {
    case .Heading_1:
        return [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24) ]
    case .Heading_2:
        return [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold) ]
    case .Heading_3:
        return [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium) ]
    case .Description:
        return [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16) ]
    }
}
