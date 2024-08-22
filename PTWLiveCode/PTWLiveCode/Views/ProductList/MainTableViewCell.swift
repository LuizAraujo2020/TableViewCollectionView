//
//  MainTableViewCell.swift
//  PTWLiveCode
//
//  Created by Luiz Araujo on 21/08/24.
//

import UIKit

protocol RowSelected: AnyObject {
    func rowSelected(_ product: ProductElement)
}

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"

    weak var delegate: RowSelected?

    var viewModel = ProductDataListViewModel()
    var prods = [ProductElement]()

    lazy var collectionView: UICollectionView = {
        let layout = ProductsFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        let  collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func addViews() {
        self.collectionView.register(ProductItemCollectionViewCell.self, forCellWithReuseIdentifier: ProductItemCollectionViewCell.identifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        self.addSubview(self.collectionView)

        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }

    func configure(products: [ProductElement]) {
        self.prods = products

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            self.collectionView.reloadData()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.prods.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductItemCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductItemCollectionViewCell else {

            let aux = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            aux.backgroundColor = UIColor.clear

            return aux
        }

        let product = self.prods[indexPath.row]

        cell.nameLabel.text = product.name
        cell.brandLabel.text = product.brand.rawValue
        cell.priceLabel.text = viewModel.formatPrice(product.basePrice)
        cell.backgroundColor = .gray

//        cell.delegate = self

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.rowSelected(self.prods[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: 5
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}

class MainAuxTableViewCell: UITableViewCell {
    static let identifier = "MainAuxTableViewCell"

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Produto"
        label.textColor =  .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 2
        return label
    }()

    lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Marca"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0,00"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()

    let stackVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalCentering
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func addViews(){

        addSubview(stackVertical)

        stackVertical.addArrangedSubview(nameLabel)
        stackVertical.addArrangedSubview(brandLabel)
        stackVertical.addArrangedSubview(priceLabel)

        stackVertical.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        stackVertical.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        stackVertical.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        stackVertical.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Used to reenable the scroll in the CollectionView inside the TableView.
extension UITableViewCell {

    open override func addSubview(_ view: UIView) {

        super.addSubview(view)

        sendSubviewToBack(contentView)
    }

}
