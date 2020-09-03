//
//  TagsCollectionViewCell.swift
//  TaggingUI
//
//  Created by Anki on 01/09/20.
//  Copyright © 2020 ankitha. All rights reserved.
//

import UIKit
protocol TagCellActions : class {
    //When close button inside the tag is called.
    func closeTapped(cell:UICollectionViewCell)
}
class TagsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundTag: UIView!{
        didSet{
            //customising the background of the cell.
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

