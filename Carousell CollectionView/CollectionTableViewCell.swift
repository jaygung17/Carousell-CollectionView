//
//  CollectionTableViewCell.swift
//  Carousell CollectionView
//
//  Created by Novan Agung Waskito on 13/12/22.
//

import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewCellDidTapItem(with viewModel: TileCollectionViewCellViewModel)
}
struct CollectionTableViewCellViewModel {
    let viewModels: [TileCollectionViewCellViewModel]
}
class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
static let identifier = "CollectionTableViewCell"
     
    private var viewModels: [TileCollectionViewCellViewModel] = []
    
    weak var delegate: CollectionTableViewCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2 )
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        //register tileCollectionView
        collectionView.register(
            TileCollectionViewCell.self,
            forCellWithReuseIdentifier: TileCollectionViewCell.identifier
        )
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    //MARK: -Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        }
    required init?(coder: NSCoder) {
        fatalError()
    }
    //MARK: -Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    //MARK: -CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(
            withReuseIdentifier: TileCollectionViewCell.identifier, for: indexPath
        ) as? TileCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    func configure(with viewModel: CollectionTableViewCellViewModel) {
        self.viewModels = viewModel.viewModels
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = contentView.frame.size.width/3
        return CGSize (width: width, height: width/1.5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at:indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
        delegate?.collectionTableViewCellDidTapItem(with: viewModel)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
