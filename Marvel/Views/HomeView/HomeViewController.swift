//
//  HomeViewController.swift
//  Marvel
//
//  Created by Alberto on 21/6/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {

    // MARK: OUTLETS
    @IBOutlet weak var tableViewHeroe: UITableView!

    // MARK: VARIABLES
    var viewModel = HomeViewModel()
    lazy var dataSource = { HomeViewControllerDataSource(viewModel: viewModel) }()

    // MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: SETUP VIEW
    func setupView() {
        registerCells()
        setupTableView()
        loadData()
    }

    func registerCells() {
        self.tableViewHeroe?.register(UINib(nibName: viewModel.misCell.xibName, bundle: nil), forCellReuseIdentifier: viewModel.misCell.idReuse)
        self.tableViewHeroe?.register(UINib(nibName: viewModel.misCellLoading.xibName, bundle: nil), forCellReuseIdentifier: viewModel.misCellLoading.idReuse)
    }

    func setupTableView() {
        self.tableViewHeroe.delegate = self
        self.tableViewHeroe.dataSource = dataSource
    }

    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.heroToSend = viewModel.heroe[indexPath.row]
        performSegue(withIdentifier: "segueInfo", sender: DetailHeroeViewController.self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let infoVC = segue.destination as? DetailHeroeViewController {
            infoVC.viewModel.heroeInfo = viewModel.heroToSend
        }
    }
}

// MARK: - PRIVATE METHODS
extension HomeViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !viewModel.isLoading {
            loadData()
        }
    }

    /// Get data from API Marvel
    func loadData() {
        viewModel.networkSetup { isLoad in
            if isLoad { self.tableViewHeroe.reloadData() }
        }
    }
}
