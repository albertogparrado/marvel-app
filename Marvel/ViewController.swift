//
//  ViewController.swift
//  Marvel
//
//  Created by Alberto on 21/6/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tableViewHeroe: UITableView!
   
    
    
    //MARK: - VARIABLES
    var misCell = MCell(xibName: "HeroeCell", idReuse: "ModelCell")
    var misCellLoading = MCell(xibName: "LoadCell", idReuse: "LoadingCell")
    var heroe: [CharacterResult] = []
    var isLoading = false
    private var offset: Int = 0
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        indicatorCircle.hidesWhenStopped = true
        
        self.tableViewHeroe?.register(UINib(nibName: misCell.xibName, bundle: nil), forCellReuseIdentifier: misCell.idReuse)
        self.tableViewHeroe?.register(UINib(nibName: misCellLoading.xibName, bundle: nil), forCellReuseIdentifier: misCellLoading.idReuse)
        
        self.tableViewHeroe.delegate = self
        self.tableViewHeroe.dataSource = self
//        self.indicatorCircle.startAnimating() //Bola de carga
        
        networkSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    var heroToSend: CharacterResult?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        heroToSend = heroe[indexPath.row]
        
        performSegue(withIdentifier: "segueInfo", sender: InfoVC.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let InfoVCSecure = segue.destination as? InfoVC {

            InfoVCSecure.heroeFull = heroToSend
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NÚMERO DE HEROES:", heroe.count)
        print("HEROES: ", heroe)
        
        if section == 0 {
            //Return the amount of items
            return heroe.count
        } else if section == 1 {
            //Return the Loading cell
            return 1
        } else {
            //Return nothing
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: misCell.idReuse, for: indexPath) as! HeroeCell
            
            cell.setData(heroes: heroe[indexPath.row])
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: misCellLoading.idReuse, for: indexPath) as! LoadCell
            
            cell.loadIcon.startAnimating()
            return cell
        }
    }
    
   
    
    private func tableView(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: misCell.idReuse, for: indexPath) as! HeroeCell
            cell.setData(heroes: heroe[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: misCellLoading.idReuse, for: indexPath) as! LoadCell
            cell.loadIcon.startAnimating()
            return cell
        }
    }
    

// MARK: - CELL LOADING


func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadMoreData()
        }
    }

func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            networkSetup()
        }
    }

}


// MARK: - PRIVATE METHODS
private extension ViewController{
    
    private func networkSetup(){
        
        NetworkClient().getCharacters(offset: offset) { result in
            switch result {
            case .success(let characters):
                guard let secureResults = characters.data?.results else{return}
                
                self.heroe.append(contentsOf: secureResults)
                
                self.offset += self.heroe.count
                
                self.tableViewHeroe.reloadData()
                
            case .failure(_):
                self.errorAlert(title: "ERROR", message: "Error al cargar los datos de Internet.")
                print("error al cargar datos desde la API")
            }
//            self.indicatorCircle.stopAnimating()//Bola de carga
            self.isLoading = false
        }
    }
    
    
    
    //ALERT 
    private func errorAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
    
        present(alert, animated: true, completion: nil)
    
    }
}








