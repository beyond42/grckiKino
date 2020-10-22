//
//  CollectionViewCell.swift
//  Grcki_Kino
//
//  Created by Ivana Todorovic on 21/10/2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.frame.origin.x = self.frame.size.width / 2 - title.frame.size.width / 2
        title.frame.origin.y = self.frame.size.height / 2 - title.frame.size.height / 2
        title.textAlignment = .center
    }
    
}
