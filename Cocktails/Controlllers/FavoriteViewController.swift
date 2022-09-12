//
//  FavoriteViewController.swift
//  Cocktails
//
//  Created by Egor Korp on 11.09.22.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController, ReloadDelegate {
    
    private var cocktails: [Cocktail] = []
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    private var imageData: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTable()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func reloadTable() {
        cocktails = []
        imageData = []
        let favoriteCocktails = realm.objects(FavoriteCoctail.self)
        for cocltail in favoriteCocktails {
            let cocktail = Cocktail(strDrink: cocltail.cocktailName, strAlcoholic: cocltail.alcaholic, strInstructions: cocltail.instruction)
            if !cocktails.contains(cocktail){
                self.imageData.append(cocltail.imageData)
                self.cocktails.append(cocktail)
            }
        }
        tableView.reloadData()
    }
}
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        if imageData.count != 0 {
            cell.imageData = imageData[indexPath.row]
        }
        cell.cocktail = cocktails[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nvc = UINavigationController(rootViewController: DetailViewController())
        let vc = nvc.topViewController as? DetailViewController
        vc?.delegate = self
        vc?.isFromFavoriteViewController = true
        vc?.imageData = imageData[self.tableView.indexPathForSelectedRow!.row]
        nvc.modalPresentationStyle = .automatic
        vc!.cocktail = cocktails[self.tableView.indexPathForSelectedRow!.row]
        tableView.deselectRow(at: indexPath, animated: true)
        present(nvc, animated: true)
    }
}
