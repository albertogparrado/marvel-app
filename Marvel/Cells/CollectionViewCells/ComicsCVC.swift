//
//  ComicsCVC.swift
//  Marvel
//
//  Created by Alberto on 26/6/21.
//

import UIKit

class ComicsCVC: UICollectionViewCell {
    // MARK: OUTLETS
    @IBOutlet weak var imageComic: UIImageView!
    // MARK: CICLE LIFE
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK: FUNCTIONS
    func setData(comic: ComicResult) {
        guard let securePath = comic.thumbnail?.path, let secureExtension = comic.thumbnail?.extensionn else { return }
        let imageUrl = "\(securePath).\(secureExtension)".replacingOccurrences(of: "http:", with: "https:")
        let url = URL(string: imageUrl)
        imageComic.kf.setImage(with: url)
    }
}
