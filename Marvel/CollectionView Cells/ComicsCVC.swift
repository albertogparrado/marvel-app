//
//  ComicsCVC.swift
//  Marvel
//
//  Created by Alberto on 26/6/21.
//

import UIKit

class ComicsCVC: UICollectionViewCell {
    
    //  MARK: OUTLETS
    @IBOutlet weak var imageComic: UIImageView!
    
    //  MARK: VARIABLES
    
    
    
    //  MARK: CICLE LIFE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setData(image: String){
        imageComic.image = UIImage(named: "comic")
            
            imageComic.cornerRadius(radius: 25)
    }
}
