//
//  HeroeCell.swift
//  Marvel
//
//  Created by Alberto on 21/6/21.
//

import UIKit
import Kingfisher

class HeroeCell: UITableViewCell {
    
    // MARK: OUTLETS
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    
    // MARK: LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: FUNTIONS
    func setData(heroe: CharacterResult) {
        setupImage(heroe: heroe)
        setupTitle(name: heroe.name ?? "")
        setupDescription(description: heroe.description ?? "")
    }
}
// MARK: PRIVATE FUNTIONS
private extension HeroeCell {
    func setupImage(heroe: CharacterResult) {
        guard let thumbnail = heroe.thumbnail?.path, let thumbExtension = heroe.thumbnail?.thumbExtension else { return }
        let url = URL(string: "https\(thumbnail.dropFirst(4)).\(thumbExtension)")
        imageCell.kf.setImage(with: url)
        imageCell.layer.cornerRadius = 10
    }
    
    func setupTitle(name: String) {
        titleCell.text = name
    }
    
    func setupDescription(description: String) {
        if description != "" {
            descriptionCell.text = description
        } else {
            descriptionCell.isHidden = true
        }
    }
}
