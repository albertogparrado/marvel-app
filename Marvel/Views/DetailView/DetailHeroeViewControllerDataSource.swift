//
//  DetailHeroeViewControllerDataSource.swift
//  Marvel
//
//  Created by Alberto on 25/10/22.
//

import Foundation
import UIKit

final class DetailHeroeViewControllerDataSource: NSObject, UICollectionViewDataSource {

    var viewModel: DetailHeroeViewModel
    var seriesCollection: UICollectionView
    var eventsCollection: UICollectionView
    var comicsCollection: UICollectionView

    init(viewModel: DetailHeroeViewModel, seriesCollection: UICollectionView, eventsCollection: UICollectionView, comicsCollection: UICollectionView) {
        self.viewModel = viewModel
        self.seriesCollection = seriesCollection
        self.eventsCollection = eventsCollection
        self.comicsCollection = comicsCollection
    }
    
    // MARK: - COLLECTION VIEW COMICS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == seriesCollection { return viewModel.seriesAPI.count }
        else if collectionView == comicsCollection { return viewModel.comicsAPI.count }
        else { return viewModel.eventsAPI.count }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == seriesCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.misCellsSeries.idReuse, for: indexPath) as? SeriesCollectionViewCell
            guard let cell = cell else { return UICollectionViewCell() }
            cell.setData(serie: viewModel.seriesAPI[indexPath.row])
            return cell
        } else if collectionView == comicsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.misCellsComics.idReuse, for: indexPath) as? ComicsCVC
            guard let cell = cell else { return UICollectionViewCell() }
            cell.setData(comic: viewModel.comicsAPI[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.misCellsEvents.idReuse, for: indexPath) as? EventsCVC
            guard let cell = cell else { return UICollectionViewCell() }
            cell.setData(event: viewModel.eventsAPI[indexPath.row])
            return cell }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == seriesCollection {
            guard let secureSerie = viewModel.seriesAPI[indexPath.row].urls?[0].url else {return}
            UIApplication.shared.open(URL(string: String(secureSerie))!)
        } else if collectionView == comicsCollection {
            guard let secureComic = viewModel.comicsAPI[indexPath.row].urls?[0].url else {return}
            UIApplication.shared.open(URL(string: String(secureComic))!)
        } else {
            guard let secureEvent = viewModel.eventsAPI[indexPath.row].urls?[0].url else {return}
            UIApplication.shared.open(URL(string: String(secureEvent))!)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == seriesCollection {
            return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.height/1.5, height: collectionView.frame.height)
        }
    }
}
