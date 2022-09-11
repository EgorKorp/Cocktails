//
//  TableViewCell.swift
//  Cocktails
//
//  Created by Egor Korp on 11.09.22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    var imageData: Data?
    
    var cocktail: Cocktail? {
        didSet {
            cocktailNameLabel.text = cocktail?.strDrink
            alcoholDescriptionLabel.text = cocktail?.strAlcoholic
            
            if cocktail?.strDrinkThumb != nil {
                DispatchQueue.global().async {
                    guard let url = URL(string: self.cocktail?.strDrinkThumb ?? "") else { return }
                    guard let data = try? Data(contentsOf: url) else { return }
                    
                    DispatchQueue.main.async {
                        self.cocktailImage.image = UIImage(data: data)
                    }
                }
            } else {
                cocktailImage.image = UIImage(data: imageData!)
            }
        }
    }
    
    
    private let cocktailNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let alcoholDescriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let cocktailImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(cocktailNameLabel)
        addSubview(alcoholDescriptionLabel)
        addSubview(cocktailImage)
        
        NSLayoutConstraint.activate([
            cocktailImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cocktailImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            cocktailImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cocktailImage.widthAnchor.constraint(equalToConstant: 80),
            
            cocktailNameLabel.leadingAnchor.constraint(equalTo: cocktailImage.trailingAnchor, constant: 10),
            cocktailNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            alcoholDescriptionLabel.leadingAnchor.constraint(equalTo: cocktailImage.trailingAnchor, constant: 10),
            alcoholDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        layoutIfNeeded()
        cocktailImage.layer.cornerRadius = cocktailImage.frame.width / 2
        cocktailImage.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
