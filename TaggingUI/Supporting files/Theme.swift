//
//  Theme.swift
//  TaggingUI
//
//  Created by Anki on 01/09/20.
//  Copyright © 2020 ankitha. All rights reserved.
//

import Foundation
import UIKit.UIColor

struct Theme {
    struct Buttons {}
}
extension Theme.Buttons {
    static func roundedButton(_ button: UIButton, title: String? = nil) {
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        if let title = title {
            button.setTitle(title, for: .normal)
        }
    }
}
