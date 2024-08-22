//
//  ViewController.swift
//  PTWLiveCode
//
//  Created by Luiz Araujo on 21/08/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RowSelected {
    func rowSelected(_ product: ProductElement) {

        let vc = DetailViewController()
        vc.product = product
        vc.view.backgroundColor = .gray

        vc.nameLabel.text = product.name
        vc.brandLabel.text = product.brand.rawValue
        vc.priceLabel.text = viewModel.formatPrice(product.basePrice)

        if let presentationController = vc.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        self.present(vc, animated: true, completion: nil)
    }

    @IBOutlet weak var tableVIew: UITableView!

    var prods = [ProductElement]()
    var viewModel = ProductDataListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableVIew.delegate = self
        self.tableVIew.dataSource = self
        self.tableVIew.estimatedRowHeight = 150
        self.tableVIew.rowHeight = UITableView.automaticDimension

        self.tableVIew.register(MainAuxTableViewCell.self, forCellReuseIdentifier: MainAuxTableViewCell.identifier)
        self.tableVIew.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        self.tableVIew.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        do {
            try RequestService().fetch(urlString: Endpoint.fetch.rawValue) { [weak self] res in
                guard let self else { return }
                self.prods = res
                print(self.prods)
                self.viewModel.products = res

                DispatchQueue.main.async {

                    self.tableVIew.reloadData()

                }
            }
        } catch {
            print(error)
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        ProductCategory.allCases.count

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        /// The Product Category has only three type that coming from API endpoint, maybe later need to change this way.
        ProductCategory.allCases[section].rawValue
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// Only one because it is the CollectionView
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {

            let aux = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            aux.backgroundColor = UIColor.clear

            return aux
        }

        let currentSection = ProductCategory.allCases[indexPath.section]
        let productsForSection = self.prods.filter({ $0.productCategory == currentSection })

        cell.configure(products: productsForSection)
        cell.collectionView.reloadData()

        cell.delegate = self
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200.0
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 130.0, height: 150.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
    }
}
