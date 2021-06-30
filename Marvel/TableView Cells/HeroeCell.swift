//
//  HeroeCell.swift
//  Marvel
//
//  Created by Alberto on 21/6/21.
//

import UIKit
import Kingfisher

class HeroeCell: UITableViewCell {
    
    // MARK: - OUTLETS
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    
    
    // MARK: - CIRCLE LIFE
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
//        accessoryType = .disclosureIndicator
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        print("He pulsado en la celda: ", titleCell.text ?? "")
    }
    
    
    // MARK: - FUNTIONS
    func setData(heroes: CharacterResult){
        
        //Carga de imagenes HTTPS
        let URLimage: String = heroes.thumbnail!.path! + "." + heroes.thumbnail!.thumbExtension!
        let URLimageHHTPS = "https" + URLimage.dropFirst(4)
        let url = URL(string: URLimageHHTPS)
        imageCell.kf.setImage(with: url)
        
        imageCell.layer.cornerRadius = 10
        
        titleCell.text = heroes.name
        
        if (heroes.description != ""){
            descriptionCell.text = heroes.description
        } else {
            descriptionCell.text = "Description not available."
        }
    }
    
}

