//
//  EventsCVC.swift
//  Marvel
//
//  Created by Alberto on 1/7/21.
//

import UIKit

class EventsCVC: UICollectionViewCell {
    // MARK: OUTLETS
    @IBOutlet weak var imageEvent: UIImageView!
    // MARK: LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK: FUNCTIONS
    func setData(event: EventResult) {
        guard let securePath = event.thumbnail?.path, let secureExtension = event.thumbnail?.extensionn else { return }
        let imageUrl = "\(securePath).\(secureExtension)".replacingOccurrences(of: "http:", with: "https:")
        let url = URL(string: imageUrl)
        imageEvent.kf.setImage(with: url)
    }
}
