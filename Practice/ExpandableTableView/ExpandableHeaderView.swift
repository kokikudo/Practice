//
//  ExpandableHeaderView.swift
//  Practice
//
//  Created by kudo koki on 2023/04/02.
//

import UIKit

class ExpandableHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: ExpandableHeaderView.self)

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    static var nib: UINib {
            return UINib(nibName: String(describing: self), bundle: nil)
        }
    
    override func awakeFromNib() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setData(type: ExpandableType) {
        title.text = type.title
    }
}
