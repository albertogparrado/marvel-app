//
//  InfoVC.swift
//  Marvel
//
//  Created by Alberto on 23/6/21.
//

import UIKit
import Kingfisher

class InfoVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var imageInfo: UIImageView!
    @IBOutlet weak var descriptionInfo: UILabel!
    @IBOutlet weak var titleHeroe: UILabel!
    
    
    //MARK: - VARIABLES
    var nameHeroInfo: String?
    var imageHeroInfo: String = ""
    var heroeFull: CharacterResult?

    
    //MARK: - CICLE LIFE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleHeroe.text = heroeFull?.name ?? ""
        
        guard let heroeFullSecure = heroeFull else {
            return
        }

        if heroeFullSecure.description == ""{
            
            descriptionInfo.text = "No description"
        } else {
            descriptionInfo.text = heroeFullSecure.description
            }

        
        //Carga de imagenes HTTPS
        let urlHTTP = heroeFullSecure.thumbnail!.path! + "." + heroeFullSecure.thumbnail!.thumbExtension!

        let URLimageHHTPS = "https" + urlHTTP.dropFirst(4)
        let url = URL(string: URLimageHHTPS)
        imageInfo.kf.setImage(with: url)
        
        print("URL IMAGEN: ", url)
    }

}
