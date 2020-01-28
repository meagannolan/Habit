//
//  HabitCell.swift
//  habitApp
//
//  Created by Meagan Nolan on 1/28/20.
//  Copyright © 2020 Meagan Nolan. All rights reserved.
//

import UIKit
import Stevia

class HabitCell: UICollectionViewCell {

    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        contentView.sv(imageView)
        imageView.followEdges(contentView)
    }
}
