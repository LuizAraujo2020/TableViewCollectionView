//
//  ProductItemCollectionViewCell.swift
//  PTWLiveCode
//
//  Created by Luiz Araujo on 21/08/24.
//

import UIKit
//
//protocol RowSelected: AnyObject {
//    func rowSelected(_ indexPath : IndexPath)
//}

//extension ProductItemCollectionViewCell: RowSelected {
//    func rowSelected(_ indexPath : IndexPath) {
//
//    }
//}

class ProductItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductItemCollectionViewCell"

    weak var delegate: RowSelected?

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()

//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.socialViewTapped))
//        self.addGestureRecognizer(tapGestureRecognizer)
//        self.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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


//    @objc
//    func socialViewTapped() {
//        self.delegate?.rowSelected(IndexPath(row: 0, section: 0))
//
//        let vc = DetailViewController()
//        //        vc.product = self.prods[indexPath.row]
//
//        //                navigationController?.pushViewController(viewControllerB, animated: true)
//        //                self.presentViewController(vc, animated: true, completion: nil)
//        //        self.present(vc, animated: true, completion: nil)
//    }
////
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let vc = DetailViewController()
////        vc.product = self.prods[indexPath.row]
////
////        //        navigationController?.pushViewController(viewControllerB, animated: true)
////        //        self.presentViewController(vc, animated: true, completion: nil)
////        self.present(vc, animated: true, completion: nil)
////
////    }
}

class ProductsFlowLayout: UICollectionViewFlowLayout {
    let itemSpacing: CGFloat = 10.0

    override init() {
        super.init()
        self.minimumLineSpacing = itemSpacing
        self.scrollDirection = .horizontal
        self.minimumInteritemSpacing = itemSpacing
        self.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
        self.itemSize = CGSize(width: 130.0, height: 150.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
