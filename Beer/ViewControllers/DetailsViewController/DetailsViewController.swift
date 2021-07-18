//
//  DetailsViewController.swift
//  Beer
//
//  Created by Anton Redkozubov on 11.07.2021.
//

import UIKit
import SnapKit
import Then
import SDWebImage

class DetailsViewController: UIViewController {

    private enum Constants {
        // MARK: - Adjust constants
        static var barViewHeight: CGFloat {
            switch UIScreen.deviceFamily {
            case .fifthFamily:
                return 60
            case .sixFamily, .plusFamily:
                return 60
            case .xFamily, .elevenFamily:
                return 80
            }
        }
        static var barViewTop: CGFloat {
            switch UIScreen.deviceFamily {
            case .fifthFamily:
                return 0
            case .sixFamily, .plusFamily:
                return 0
            case .xFamily, .elevenFamily:
                return 0
            }
        }
    }

    var searchResponse: DataModel?
    var list = [IngredientItem]()

    private lazy var backView: UIView = {
        let back = UIView()
        return back
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Назад", for: .normal)
        return button
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        return scrollView
    }()

    private lazy var box: UIView = {
        let uiview = UIView()

        return uiview
    }()

    private lazy var beerImg: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        return img
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var descrLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private lazy var pairingLabel: UILabel = {
        let label = UILabel()
        label.text = "Food Pairing"
        return label
    }()

    private lazy var foodPairingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private lazy var ingredient: UILabel = {
        let label = UILabel()
        label.text = "Ingredient"
        return label
    }()

    private lazy var tableBeer: UITableView = {
        let table = UITableView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        backButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }

    func setupUI() {
        view.backgroundColor = .secondarySystemBackground

        tableBeer.delegate = self
        tableBeer.dataSource = self
        nameLabel.text = searchResponse?.name
        descrLabel.text = searchResponse?.description
        tableBeer.backgroundColor = .secondarySystemBackground
        tableBeer.separatorStyle = .none
        tableBeer.showsVerticalScrollIndicator = false
        var foodString = ""
        searchResponse?.foodPairing.forEach {
            foodString += $0 + "\n"
        }
        foodPairingLabel.text = foodString
        if let url = URL(string: searchResponse?.imageUrl ?? "") {
            self.beerImg.sd_setImage(with: url, completed: nil )
        }
        list.removeAll()
        searchResponse?.ingredients.hops.forEach {
            list.append($0)
        }
        searchResponse?.ingredients.malt.forEach {
            list.append($0)
        }
        print(list.count)
        tableBeer.reloadData()
    }

    @objc func closeButtonTapped() {
        print(#function)
        backToVc()
    }

    func backToVc() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Constrains
    override func loadView() {
        super.loadView()
        view.addSubview(backView)
        backView.addSubview(backButton)
        view.addSubview(scrollView)
        scrollView.addSubview(box)
        box.addSubview(beerImg)
        box.addSubview(pairingLabel)
        box.addSubview(nameLabel)
        box.addSubview(descrLabel)
        box.addSubview(foodPairingLabel)
        box.addSubview(ingredient)
        box.addSubview(tableBeer)

        backView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview().offset(Constants.barViewTop)
            $0.height.equalTo(Constants.barViewHeight)
        }

        backButton.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.width.equalTo(grid.space90)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(grid.space50)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(backView.snp.bottom).offset(grid.space8)
            $0.left.bottom.right.equalToSuperview()
        }

        box.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }

        beerImg.snp.makeConstraints { make in
            make.top.equalTo(box).inset(grid.space50)
            make.trailing.leading.equalToSuperview().inset(grid.space50)
            make.height.equalTo(grid.space400)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(beerImg.snp.bottom).offset(grid.space30)
            make.centerX.equalToSuperview()
        }

        descrLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(grid.space30)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(grid.space50)
        }

        pairingLabel.snp.makeConstraints { make in
            make.top.equalTo(descrLabel.snp.bottom).offset(grid.space30)
            make.centerX.equalToSuperview()
        }

        foodPairingLabel.snp.makeConstraints { make in
            make.top.equalTo(pairingLabel.snp.bottom).offset(grid.space30)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(grid.space50)
        }

        ingredient.snp.makeConstraints { make in
            make.top.equalTo(foodPairingLabel.snp.bottom).offset(grid.space30)
            make.centerX.equalToSuperview()
        }

        tableBeer.snp.makeConstraints { make in
            make.top.equalTo(ingredient.snp.bottom).offset(grid.space30)
            make.centerX.equalToSuperview()
            make.height.equalTo(grid.space400)
            make.leading.trailing.equalToSuperview().inset(grid.space50)
            make.bottom.equalTo(box).offset(-grid.space20)
        }
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = IngredientViewCell()
        cell.backgroundColor = .secondarySystemBackground
        let model = list[indexPath.row]
        cell.setData(model: model)
        return cell
    }
}

private extension Grid {
    /// Размер таблицы и картинки
    var space400: CGFloat { 400 }
}
