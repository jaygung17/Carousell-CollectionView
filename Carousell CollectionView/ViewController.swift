//
//  ViewController.swift
//  Carousell CollectionView
//
//  Created by Novan Agung Waskito on 13/12/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    private let viewModels: [CollectionTableViewCellViewModel ] = [
    CollectionTableViewCellViewModel(
        viewModels: [
            TileCollectionViewCellViewModel(name: "Apple", backgroundColor: .gray),
            TileCollectionViewCellViewModel(name: "Tiktok", backgroundColor: .black),
            TileCollectionViewCellViewModel(name: "Shopee", backgroundColor: .orange),
            TileCollectionViewCellViewModel(name: "Tokopedia", backgroundColor: .green),
            TileCollectionViewCellViewModel(name: "Binus", backgroundColor: .systemPurple),
            TileCollectionViewCellViewModel(name: "Singapore", backgroundColor: .systemPink),
            TileCollectionViewCellViewModel(name: "adpList", backgroundColor: .systemCyan)
        ]
    )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource =  self
        tableView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
       guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CollectionTableViewCell.identifier,
            for: indexPath
        ) as? CollectionTableViewCell else {
            fatalError()
        }
        cell.delegate = self
        cell.configure(with: viewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width/2
    }
}

extension ViewController: CollectionTableViewCellDelegate {
    func collectionTableViewCellDidTapItem(with viewModel: TileCollectionViewCellViewModel) {
        let alert = UIAlertController (title: viewModel.name,
                                       message: "You successfully got the selected item!",
                                       preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel))
        present(alert, animated: true)
    }
}

