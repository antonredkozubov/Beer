//
//  ViewController.swift
//  Beer
//
//  Created by Anton Redkozubov on 08.07.2021.
//

import UIKit
import SnapKit
import Then
import SDWebImage

class ViewController: UIViewController {

    let networkDataFetcher = NetworkDataFetcher()
    var searchResponse = [DataModel]()

    var refreshControl: UIRefreshControl? = UIRefreshControl()

    var page: Int = 1
    var perPage: Int = 50

    private lazy var beerTable = UITableView().then {
        $0.rowHeight = 100
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.beerTable.refreshControl = self.refreshControl
        self.refreshControl?.addTarget(self, action: #selector(loadNextItems), for: .valueChanged)

        setupUI()
        loadNextItems()
        }

    @objc func loadNextItems() {
        self.refreshControl?.beginRefreshing()
        networkDataFetcher.fetchBeers(urlString: Url.beers(page: page,
                                                           perPage: perPage)) { (searchResponse) in
            guard let searchResponse = searchResponse else {
                self.refreshControl?.endRefreshing()
                return
            }
            self.refreshControl?.endRefreshing()
            print("page, \(self.page)")
            self.page += 1
            searchResponse.forEach {
                self.searchResponse.append($0)
            }
            self.beerTable.reloadData()
        }
    }

    func showDetail(data: DataModel) {
        let detailVC = DetailsViewController()
        detailVC.searchResponse = data
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true, completion: nil)
    }

    func setupUI() {
        beerTable.delegate = self
        beerTable.dataSource = self
        beerTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        beerTable.backgroundColor = .secondarySystemBackground

    }

    override func loadView() {
        super.loadView()
        view.addSubview(beerTable)

        beerTable.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = searchResponse[indexPath.row]
        showDetail(data: beer)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell()
        let beer = searchResponse[indexPath.row]
        cell.setData(model: beer)
        return cell
    }

}
