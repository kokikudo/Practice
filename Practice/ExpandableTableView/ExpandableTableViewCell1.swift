//
//  ExpandableTableViewCell.swift
//  Practice
//
//  Created by kudo koki on 2023/04/02.
//

import UIKit

class ExpandableTableViewCell1: UITableViewCell {
    static let reuseIdentifier: String = String(describing: ExpandableTableViewCell1.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension UITableViewCell {
    
    
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    
    
}
