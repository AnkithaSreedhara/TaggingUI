//
//  UIViewNib.swift
//  TaggingUI
//
//  Created by Anki on 02/09/20.
//  Copyright © 2020 ankitha. All rights reserved.
//

import Foundation
import UIKit

protocol ViewWithNib {

    static var nibName: String { get }
}

extension ViewWithNib {

    static var nibName: String { return String(describing: `self`) }
}

extension ViewWithNib where Self: UIView {

    static func nib(bundle: Bundle = .main) -> UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }

    static func loadFromNib(bundle: Bundle = .main, owner: Any? = nil, options: [AnyHashable: Any]? = nil, frame: CGRect? = nil) -> Self {

        for view in nib(bundle: bundle).instantiate(withOwner: owner, options: options as? [UINib.OptionsKey : Any]) {
            if let view = view as? Self {
                if let frame = frame { view.frame = frame }
                return view
            }
        }

        fatalError("No object of class \(Self.self) in nib (named: \(nibName), bundle: \(String(describing: bundle)))")
    }
}
