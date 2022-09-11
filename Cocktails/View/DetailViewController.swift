//
//  DetailViewController.swift
//  Cocktails
//
//  Created by Egor Korp on 11.09.22.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var cocktail: Cocktail?
    var isFromFavoriteViewController = false
    var imageData: Data?
    var delegate: ReloadDelegate?
    
    
    private var righBarButtonItem: UIBarButtonItem!{
        didSet {
            navigationItem.rightBarButtonItem = righBarButtonItem
        }
    }
    
    private let instructionLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let cocktailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancel))
        setupView()
        
        if checkForUnic() == false {
            righBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(saveCocktail))
        } else {
            righBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(deleteCocktail))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isFromFavoriteViewController == true {
            delegate?.reloadTable()
        }
    }
    
    private func setupView() {
        view.addSubview(cocktailImage)
        view.addSubview(instructionLabel)
        
        view.backgroundColor = .systemBackground
        title = cocktail?.strDrink
        
        instructionLabel.font = .systemFont(ofSize: 18)
        instructionLabel.isSelectable = false
        
        
        if isFromFavoriteViewController == false {
            instructionLabel.text = "Ingridents: \(getIngridents()).\nInstructions: \(cocktail?.strInstructions ?? "")"
            
            DispatchQueue.global().async {
                guard let url = URL(string: self.cocktail?.strDrinkThumb ?? "") else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                
                DispatchQueue.main.async {
                    self.cocktailImage.image = UIImage(data: data)
                }
            }
        } else {
            instructionLabel.text = cocktail?.strInstructions
            cocktailImage.image = UIImage(data: imageData!)
        }
        
        NSLayoutConstraint.activate([
            cocktailImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            cocktailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cocktailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cocktailImage.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            cocktailImage.heightAnchor.constraint(equalTo: cocktailImage.widthAnchor),
            instructionLabel.topAnchor.constraint(equalTo: cocktailImage.bottomAnchor),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            instructionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func getIngridents() -> String {
        guard let cocktail = cocktail else { return "" }
        var finalIngridient = ""
        finalIngridient += "\(cocktail.strIngredient1!)"
        
        if cocktail.strIngredient2 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient2!)"
        
        if cocktail.strIngredient3 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient3!)"
        
        if cocktail.strIngredient4 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient4!)"
        
        if cocktail.strIngredient5 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient5!)"
        
        if cocktail.strIngredient6 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient6!)"
        
        if cocktail.strIngredient7 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient7!)"
        
        if cocktail.strIngredient8 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient8!)"
        
        if cocktail.strIngredient9 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient9!)"
        
        if cocktail.strIngredient10 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient10!)"
        
        if cocktail.strIngredient11 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient11!)"
        
        if cocktail.strIngredient12 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient12!)"
        
        if cocktail.strIngredient13 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient13!)"
        
        if cocktail.strIngredient14 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient14!)"
        
        if cocktail.strIngredient15 == nil {
            return finalIngridient
        }
        finalIngridient += ", \(cocktail.strIngredient15!)"
        
        
        return finalIngridient
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    @objc func saveCocktail() {
        let FavoriteCoctail = FavoriteCoctail()
        FavoriteCoctail.cocktailName = title ?? ""
        FavoriteCoctail.instruction = instructionLabel.text
        FavoriteCoctail.imageData = (cocktailImage.image?.pngData())!
        FavoriteCoctail.alcaholic = cocktail?.strAlcoholic ?? ""
        
        
        
        StorageManager.savedData(FavoriteCoctail)
        righBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(deleteCocktail))
    }
    
    private func checkForUnic() -> Bool {
        let cocktails = realm.objects(FavoriteCoctail.self).contains {
            $0.cocktailName == title
        }
        
        return cocktails
    }
    
    @objc func deleteCocktail() {
        let FavoriteCoctail = FavoriteCoctail()
        FavoriteCoctail.cocktailName = title ?? ""
        FavoriteCoctail.instruction = instructionLabel.text
        FavoriteCoctail.imageData = (cocktailImage.image?.pngData())!
        FavoriteCoctail.alcaholic = cocktail?.strAlcoholic ?? ""
        StorageManager.removedData(FavoriteCoctail)
        dismiss(animated: true)
    }
    
    
    
}
