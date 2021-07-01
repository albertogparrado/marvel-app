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
    
    
    func setData(comic: ComicResult){
        //Carga de imagenes HTTPS
        guard let securePath = comic.thumbnail?.path, let secureExtension = comic.thumbnail?.extensionn else {
            return
        }
        
        let URLimage: String = "\(securePath).\(secureExtension)"
//        let URLimageHHTPS = "https" + URLimage.dropFirst(4)
        let aaa = URLimage.replacingOccurrences(of: "http", with: "https")
        let url = URL(string: aaa)
        imageComic.kf.setImage(with: url)
        
        
    }
}
