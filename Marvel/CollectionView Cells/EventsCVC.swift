//
//  EventsCVC.swift
//  Marvel
//
//  Created by Alberto on 1/7/21.
//

import UIKit

class EventsCVC: UICollectionViewCell {
  
//    MARK: OUTLETS
    @IBOutlet weak var imageEvent: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(event: EventResult){
        //Carga de imagenes HTTPS
        guard let securePath = event.thumbnail?.path, let secureExtension = event.thumbnail?.extensionn else {
            return
        }
        
        let URLimage: String = "\(securePath).\(secureExtension)"
        let htpps = URLimage.replacingOccurrences(of: "http", with: "https")
        let url = URL(string: htpps)
        imageEvent.kf.setImage(with: url)
    }
}
