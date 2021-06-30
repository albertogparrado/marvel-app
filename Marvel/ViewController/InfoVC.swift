//
//  InfoVC.swift
//  Marvel
//
//  Created by Alberto on 23/6/21.
//

import UIKit
import Kingfisher

class InfoVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: - OUTLETS
    @IBOutlet weak var imageInfo: UIImageView!
    @IBOutlet weak var descriptionInfo: UILabel!
    @IBOutlet weak var titleHeroe: UILabel!
    //collections
    @IBOutlet weak var seriesCollection: UICollectionView!
    @IBOutlet weak var eventsCollection: UICollectionView!
    @IBOutlet weak var comicsCollection: UICollectionView!
    
    
    //MARK: - VARIABLES
    var nameHeroInfo: String?
    var imageHeroInfo: String = ""
    var heroeFull: CharacterResult?
    var seriesAPI: [SerieResult] = []
    //    var comics: [ComicsResult?] = []
    private var offset: Int = 0
    var misCellsComics: MCell = MCell(xibName: "ComicsCVC", idReuse: "ComicCell")
    var misCellsSeries: MCell = MCell(xibName: "SeriesCollectionViewCell", idReuse: "SerieCell")
    
    
    //MARK: - CICLE LIFE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSeriesCollection()
        
        setupBasicHeroData()

        infoSeries()

    }
    
    
    //  MARK:- COLLECTION VIEW COMICS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return seriesAPI.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == seriesCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: misCellsSeries.idReuse, for: indexPath) as! SeriesCollectionViewCell
            cell.setData(serie: seriesAPI[indexPath.row])
            return cell
            
        } else {//} if (collectionView == comicsCollection){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: misCellsComics.idReuse, for: indexPath) as! ComicsCVC
            cell.setData(image: "comic")
            return cell
            
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TOUCH ON:", indexPath.row)
        
        //        performSegue(withIdentifier: "SegueTable", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height/1.5, height: collectionView.frame.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let defaultSize = CGSize(width: collectionView.frame.height/1.5, height: collectionView.frame.height)
//            if collectionView == self.comicsCollection { return defaultSize } else
//            if collectionView == self.seriesCollection { return defaultSize } else
//            if collectionView == self.eventsCollection { return defaultSize }
//            return defaultSize
//        }
    
}


// MARK: PRIVATE METHOS
private extension InfoVC{
    
    //    private func infoComics(id: Int){
    //
    //        NetworkComics().getComics(characterID: id)
    //        { result in
    //            switch result {
    //            case .success(let serie):
    //                guard let secureResults = serie.data?.results else{return}
    //                print(secureResults)
    //
    //            case .failure(_):
    //                print("error al cargar datos desde la API")
    //            }
    //
    //        }
    //
    //    }
    
     func infoSeries() {
        //ID:
        guard let comicSecureID = heroeFull?.id else {
            return
        }
        
        NetworkClient().getSeries(characterID: comicSecureID, offset: 0) { result in
            switch result {
            case .success(let series):
                guard let secureResults = series.data?.results else{return}
                self.seriesAPI = secureResults
                self.seriesCollection.reloadData()
                print("SERIES API:", self.seriesAPI)
                
            case .failure(_):
                print("error al cargar datos desde la API")
            }
            
        }
        
    }
    
    
    func setupBasicHeroData(){
        guard let heroeFullSecure = heroeFull else {
            return
        }
        titleHeroe.text = heroeFullSecure.name
        
        if heroeFullSecure.description == ""{
            descriptionInfo.text = "No description"
        } else{
            descriptionInfo.text = heroeFullSecure.description
        }
        
        //Carga de imagenes HTTPS
        let urlHTTP = heroeFullSecure.thumbnail!.path! + "." + heroeFullSecure.thumbnail!.thumbExtension!
        let URLimageHHTPS = "https" + urlHTTP.dropFirst(4)
        let url = URL(string: URLimageHHTPS)
        imageInfo.kf.setImage(with: url)
    }
    
    func setupSeriesCollection(){
        //Collection
        seriesCollection.dataSource = self
        seriesCollection.delegate = self
        
        //registrall cell collection
        seriesCollection.register(UINib(nibName: misCellsSeries.xibName, bundle: nil), forCellWithReuseIdentifier: misCellsSeries.idReuse)
    }
    
    
}

