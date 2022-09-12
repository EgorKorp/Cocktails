//
//  SearchViewController.swift
//  Cocktails
//
//  Created by Egor Korp on 11.09.22.
//

import UIKit

class SearchViewContoller: UIViewController {
    
    private var cocktails: [Cocktail] = []
    private let networkFetcher = Networking()
    private let searchContoller = UISearchController()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupSearchController()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    
    
    // MARK: Navigation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nvc = UINavigationController(rootViewController: DetailViewController())
        let vc = nvc.topViewController as? DetailViewController
        vc?.isFromFavoriteViewController = false
        nvc.modalPresentationStyle = .automatic
        vc!.cocktail = cocktails[self.tableView.indexPathForSelectedRow!.row]
        tableView.deselectRow(at: indexPath, animated: true)
        present(nvc, animated: true)
    }
    
}
extension SearchViewContoller: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.cocktail = cocktails[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}






extension SearchViewContoller: UISearchControllerDelegate, UISearchBarDelegate {
    
    private func setupSearchController(){
        navigationItem.searchController = searchContoller
        searchContoller.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(searchText)"
        
        networkFetcher.fetchData(urlString: urlString) { cocktails in
            guard let cocktails = cocktails else { return }
            self.cocktails = cocktails.drinks
            self.tableView.reloadData()
        }
    }
}


