//
//  Strings.swift
//  TaggingUI
//
//  Created by Anki on 01/09/20.
//  Copyright © 2020 ankitha. All rights reserved.
//

import Foundation
extension String {
  var localized: String {
    return NSLocalizedString(self, comment: .empty)
  }
}
import Foundation
public extension String {
  static let empty: String = ""
}
