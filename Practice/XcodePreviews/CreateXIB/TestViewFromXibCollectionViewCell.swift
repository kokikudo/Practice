//
//  TestViewFromXibCollectionViewCell.swift
//  Practice
//
//  Created by kudo koki on 2023/04/08.
//

import UIKit

class TestViewFromXibCollectionViewCell: UICollectionViewCell {

    static let className = "TestViewFromXibCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.red.cgColor
        layer.cornerRadius = 4.0
    }

    func configure(text: String) {
        titleLabel.text = text + " OK"
    }
}
