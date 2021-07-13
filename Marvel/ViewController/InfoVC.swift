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
    var comicsAPI: [ComicResult] = []
    var eventsAPI: [EventResult] = []
    private var offset: Int = 0
    var misCellsComics: MCell = MCell(xibName: "ComicsCVC", idReuse: "ComicCell")
    var misCellsSeries: MCell = MCell(xibName: "SeriesCollectionViewCell", idReuse: "SerieCell")
    var misCellsEvents: MCell = MCell(xibName: "EventsCVC", idReuse: "EventCell")
    
    
    //MARK: - LIFE CYRCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSeriesCollection()
        
        setupBasicHeroData()
        
        infoSeries()
        infoComics()
        infoEvents()
        
    }
    
    
    //  MARK:- COLLECTION VIEW COMICS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == seriesCollection {return seriesAPI.count} else
        if collectionView == comicsCollection {return comicsAPI.count} else {
            return eventsAPI.count}
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == seriesCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: misCellsSeries.idReuse, for: indexPath) as! SeriesCollectionViewCell
            cell.setData(serie: seriesAPI[indexPath.row])
            return cell
            
        } else if (collectionView == comicsCollection){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: misCellsComics.idReuse, for: indexPath) as! ComicsCVC
            cell.setData(comic: comicsAPI[indexPath.row])
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: misCellsEvents.idReuse, for: indexPath) as! EventsCVC
            cell.setData(event: eventsAPI[indexPath.row])
            return cell
        }
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TOUCH ON:", indexPath.row)
        
        if collectionView == seriesCollection {

            guard let secureSerie = seriesAPI[indexPath.row].urls?[0].url else {return}
            print(secureSerie)
            //Abrir navegador con esa URL
            UIApplication.shared.open(URL(string: String(secureSerie))!)
            
        } else if (collectionView == comicsCollection){
            guard let secureComic = comicsAPI[indexPath.row].urls?[0].url else {return}
            print(secureComic)
            //Abrir navegador con esa URL
            UIApplication.shared.open(URL(string: String(secureComic))!)
            
        } else {
            guard let secureEvent = eventsAPI[indexPath.row].urls?[0].url else {return}
            print(secureEvent)
            //Abrir navegador con esa URL
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


// MARK: PRIVATE METHOS
private extension InfoVC{
    
    func infoComics(){
        //ID:
        guard let heroIDSecure = heroeFull?.id else {
            return
        }
        
        NetworkClient().getComics(characterID: heroIDSecure, offset: 0) { result in
            switch result {
            case .success(let comics):
                guard let secureResults = comics.data?.results else{return}
                self.comicsAPI = secureResults
                self.comicsCollection.reloadData()
                
            case .failure(_):
                print("error al cargar datos desde la API")
            }
            
        }
        
    }
    
    func infoSeries() {
        //ID:
        guard let heroIDSecure = heroeFull?.id else {
            return
        }
        
        NetworkClient().getSeries(characterID: heroIDSecure, offset: 0) { result in
            switch result {
            case .success(let series):
                guard let secureResults = series.data?.results else{return}
                self.seriesAPI = secureResults
                self.seriesCollection.reloadData()
                
            case .failure(_):
                print("error al cargar datos desde la API")
            }
            
        }
        
    }
    
    func infoEvents() {
        //ID:
        guard let heroIDSecure = heroeFull?.id else {
            return
        }
        
        NetworkClient().getEvents(characterID: heroIDSecure, offset: 0) { result in
            switch result {
            case .success(let series):
                guard let secureResults = series.data?.results else{return}
                self.eventsAPI = secureResults
                self.eventsCollection.reloadData()
                
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
        comicsCollection.dataSource = self
        comicsCollection.delegate = self
        eventsCollection.dataSource = self
        eventsCollection.delegate = self
        
        //registrall cell collection
        seriesCollection.register(UINib(nibName: misCellsSeries.xibName, bundle: nil), forCellWithReuseIdentifier: misCellsSeries.idReuse)
        comicsCollection.register(UINib(nibName: misCellsComics.xibName, bundle: nil), forCellWithReuseIdentifier: misCellsComics.idReuse)
        eventsCollection.register(UINib(nibName: misCellsEvents.xibName, bundle: nil), forCellWithReuseIdentifier: misCellsEvents.idReuse)
    }
    
    
}

