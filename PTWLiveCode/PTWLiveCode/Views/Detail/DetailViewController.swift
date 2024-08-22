//
//  DetailViewController.swift
//  PTWLiveCode
//
//  Created by Luiz Araujo on 21/08/24.
//

import UIKit

class DetailViewController: UIViewController {
    var product: ProductElement!

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Produto"
        label.textColor =  .black
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 2
        return label
    }()

    lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Marca"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()


    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0,00"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()

    let stackVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
    }

    func addViews() {
        view.addSubview(stackVertical)

        stackVertical.addArrangedSubview(nameLabel)
        stackVertical.addArrangedSubview(brandLabel)
        stackVertical.addArrangedSubview(priceLabel)

        stackVertical.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        stackVertical.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 28).isActive = true
        stackVertical.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -28).isActive = true
        stackVertical.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
