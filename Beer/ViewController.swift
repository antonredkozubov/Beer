//
//  ViewController.swift
//  Beer
//
//  Created by Anton Redkozubov on 08.07.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let networkDataFetcher = NetworkDataFetcher()
    var searchResponse: DataResponse? = nil
    var networkService: NetworkService? = nil

    private lazy var beerTable: UITableView = {
        let table = UITableView()
        table.rowHeight = 100
        table.backgroundColor = .white
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        }

    func setupUI() {
        beerTable.delegate = self
        beerTable.dataSource = self

        beerTable.backgroundColor = .white
        beerTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }

    override func loadView() {
        super.loadView()
        view.addSubview(beerTable)

        beerTable.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    @objc func startLoad() {
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(dataLoaded),
                             userInfo: nil, repeats: false)
        net("https://rickandmortyapi.com/api/character/")
    }

    @objc func dataLoaded() {
//        self.refreshControl?.endRefreshing()
        self.beerTable.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.dataModel.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = beerTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let beer = searchResponse?.dataModel[indexPath.row]
        print("track?.artworkUrl60:", beer?.imageUrl)
        cell.textLabel?.text = beer?.name
        return cell
    }

}
