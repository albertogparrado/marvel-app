//
//  SeriesCollectionViewCell.swift
//  Marvel
//
//  Created by Alberto on 30/6/21.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    
    //    MARK: OULETS
    @IBOutlet weak var imageSerie: UIImageView!
    
    //    MARK: LIFE CYRCLE
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        imageSerie.cornerRadius(radius: 10)
//    }
    
    func setData(serie: SerieResult){
        //Carga de imagenes HTTPS
        guard let securePath = serie.thumbnail?.path, let secureExtension = serie.thumbnail?.extensionn else {
            return
        }
        
        let URLimage: String = "\(securePath).\(secureExtension)"
//        let URLimageHHTPS = "https" + URLimage.dropFirst(4)
        let aaa = URLimage.replacingOccurrences(of: "http", with: "https")
        let url = URL(string: aaa)
        imageSerie.kf.setImage(with: url)
        
        
    }

}
