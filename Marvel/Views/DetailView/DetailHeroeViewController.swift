//
//  DetailHeroeViewController.swift
//  Marvel
//
//  Created by Alberto on 23/6/21.
//

import UIKit
import Kingfisher

class DetailHeroeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: OUTLETS
    @IBOutlet weak var imageInfo: UIImageView!
    @IBOutlet weak var descriptionInfo: UILabel!
    @IBOutlet weak var titleHeroe: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    // Collections
    @IBOutlet weak var seriesTitle: UILabel!
    @IBOutlet weak var seriesCollection: UICollectionView!
    @IBOutlet weak var eventsTitle: UILabel!
    @IBOutlet weak var eventsCollection: UICollectionView!
    @IBOutlet weak var comicsTitle: UILabel!
    @IBOutlet weak var comicsCollection: UICollectionView!
    
    // MARK: VARIABLES
    var viewModel = DetailHeroeViewModel()
    lazy var dataSource = {
        DetailHeroeViewControllerDataSource(viewModel: self.viewModel, seriesCollection: self.seriesCollection, eventsCollection: self.eventsCollection, comicsCollection: self.comicsCollection)
    }()

    // MARK: LIFE CYRCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        spinner.startAnimating()
        loadData()
    }
}

// MARK: PRIVATE FUNCTIONS
private extension DetailHeroeViewController {
    
    func setupView() {
        setupTitleHeroe()
        setupImageHeroe()
        setupDescriptionHeroe()
        registerCells()
        setupCollections()
    }
    
    func setupTitleHeroe() {
        guard let infoHeroe = viewModel.heroeInfo else { return }
        titleHeroe.text = infoHeroe.name
    }
    
    func setupDescriptionHeroe() {
        guard let infoHeroe = viewModel.heroeInfo else { return }
        if infoHeroe.description == "" {
            descriptionInfo.isHidden = true
        } else {
            descriptionInfo.text = infoHeroe.description
        }
    }
    
    func setupImageHeroe() {
        guard let url = viewModel.createUrlImageHeroe() else { return }
        imageInfo.kf.setImage(with: url)
    }
    
    func registerCells() {
        seriesCollection.register(UINib(nibName: viewModel.misCellsSeries.xibName, bundle: nil), forCellWithReuseIdentifier: viewModel.misCellsSeries.idReuse)
        comicsCollection.register(UINib(nibName: viewModel.misCellsComics.xibName, bundle: nil), forCellWithReuseIdentifier: viewModel.misCellsComics.idReuse)
        eventsCollection.register(UINib(nibName: viewModel.misCellsEvents.xibName, bundle: nil), forCellWithReuseIdentifier: viewModel.misCellsEvents.idReuse)
    }
    
    func setupCollections() {
        seriesCollection.dataSource = dataSource
        seriesCollection.delegate = self
        comicsCollection.dataSource = dataSource
        comicsCollection.delegate = self
        eventsCollection.dataSource = dataSource
        eventsCollection.delegate = self
    }
    
    func loadData() {
        self.comicsCollection.isHidden = true
        self.comicsTitle.isHidden = true
        self.eventsCollection.isHidden = true
        self.eventsTitle.isHidden = true
        self.seriesCollection.isHidden = true
        self.seriesTitle.isHidden = true
        
        var comicsLoaded = false
        var seriesLoaded = false
        var eventsLoaded = false
        
        viewModel.loadDataComics { isLoad in
            if isLoad {
                if !self.viewModel.comicsAPI.isEmpty {
                    self.comicsCollection.isHidden = false
                    self.comicsTitle.isHidden = false
                }
                comicsLoaded = true
                if comicsLoaded && seriesLoaded && eventsLoaded {
                    self.comicsCollection.reloadData()
                }
            }
        }
        viewModel.loadDataEvents { isLoad in
            if isLoad {
                if !self.viewModel.eventsAPI.isEmpty {
                    self.eventsCollection.isHidden = false
                    self.eventsTitle.isHidden = false
                }
                self.eventsCollection.reloadData()
                eventsLoaded = true
                if comicsLoaded && seriesLoaded && eventsLoaded {
                    self.comicsCollection.reloadData()
                }
            }
        }
        viewModel.loadDataSeries { isLoad in
            if isLoad {
                if !self.viewModel.seriesAPI.isEmpty {
                    self.seriesCollection.isHidden = false
                    self.seriesTitle.isHidden = false
                }
                self.seriesCollection.reloadData()
                self.spinner.stopAnimating()
                seriesLoaded = true
                if comicsLoaded && seriesLoaded && eventsLoaded {
                    self.comicsCollection.reloadData()
                }
            }
        }
    }
}
