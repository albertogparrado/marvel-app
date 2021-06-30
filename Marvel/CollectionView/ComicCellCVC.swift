//
//  ComicCellCVC.swift
//  Marvel
//
//  Created by Alberto on 26/6/21.
//

import UIKit

class ComicCellCVC: UICollectionViewCell {
    @IBOutlet weak var titleComic: UILabel!
    @IBOutlet weak var imageComic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleComic.text = "Aquí va el título"
//        imageComic = UIImageView(image: UIImage?)
        
    }

}
