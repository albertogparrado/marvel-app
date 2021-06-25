//
//  HomeTVC.swift
//  Marvel
//
//  Created by Alberto on 21/6/21.
//

import UIKit

class HomeTVC: UITableViewController {
    
    let client = NetworkClient()

    override func viewDidLoad() {
        super.viewDidLoad()

            
            let dataAPI = client.getCharacters { result in
    //            print("Datos ViewController: ", result)
            }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

    
}
