//
//  HelperFunction.swift
//  Editor
//
//  Created by GAURAV NAYAK on 15/06/20.
//  Copyright © 2020 CaffeineDevotee. All rights reserved.
//

import Foundation
import UIKit

func getTextAttribute(type : TextFormat) -> [NSAttributedString.Key : Any] {
    switch type {
    case .Heading_1:
        return [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30) ]
    case .Heading_2:
        return [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold) ]
    case .Heading_3:
        return [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium) ]
    case .Description:
        return [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16) ]
    }
}
