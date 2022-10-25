//
//  HomeViewControllerDataSource.swift
//  Marvel
//
//  Created by Alberto on 24/10/22.
//

import Foundation
import UIKit

final class HomeViewControllerDataSource: NSObject, UITableViewDataSource {
    var viewModel: HomeViewModel
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.heroe.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.misCell.idReuse, for: indexPath) as? HeroeCell
            guard let cell = cell else { return UITableViewCell() }
            cell.setData(heroe: viewModel.heroe[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.misCellLoading.idReuse, for: indexPath) as? LoadCell
            guard let cell = cell else { return UITableViewCell() }
            cell.loadIcon.startAnimating()
            return cell
        }
    }
    // MARK: - CELL LOADING
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
