//
//  TagsCollectionViewCell.swift
//  TaggingUI
//
//  Created by Anki on 01/09/20.
//  Copyright © 2020 ankitha. All rights reserved.
//

import UIKit
protocol TagCellActions : class {
    func closeTapped(cell:UICollectionViewCell)
}
class TagsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundTag: UIView!{
        didSet{
            backgroundTag.clipsToBounds = true
            backgroundTag.layer.cornerRadius = 15
            backgroundTag.layer.borderColor = UIColor.darkGray.cgColor
            backgroundTag.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var nameOfTag: UILabel!
    weak var delegate : TagCellActions?
    @IBAction func closeTapped(_ sender: Any) {
        delegate?.closeTapped(cell: self)
    }
}

