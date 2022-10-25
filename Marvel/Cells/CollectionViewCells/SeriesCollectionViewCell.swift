//
//  SeriesCollectionViewCell.swift
//  Marvel
//
//  Created by Alberto on 30/6/21.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    // MARK: OULETS
    @IBOutlet weak var imageSerie: UIImageView!
    // MARK: FUNCTIONS
    func setData(serie: SerieResult) {
        guard let securePath = serie.thumbnail?.path, let secureExtension = serie.thumbnail?.extensionn else { return }
        let imageUrl = "\(securePath).\(secureExtension)".replacingOccurrences(of: "http:", with: "https:")
        let url = URL(string: imageUrl)
        imageSerie.kf.setImage(with: url)
    }
}
