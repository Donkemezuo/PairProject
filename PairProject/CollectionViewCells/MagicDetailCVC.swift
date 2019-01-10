//
//  MagicDetailCVC.swift
//  PairProject
//
//  Created by Ibraheem rawlinson on 1/9/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class MagicDetailCVC: UICollectionViewCell {
    @IBOutlet weak var magicImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var language: UILabel!
    
    @IBOutlet weak var text: UITextView!

    override func prepareForReuse() {
        magicImage.image = UIImage.init(named: "magic")
    }
}
