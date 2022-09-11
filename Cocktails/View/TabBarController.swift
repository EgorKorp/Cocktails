//
//  TabBarController.swift
//  Cocktails
//
//  Created by Egor Korp on 11.09.22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers(
            [
                configureVC(rootVC: SearchViewContoller(), tabBarTitle: "Search", viewControllerTitle: "Cocktails", image: UIImage(systemName: "magnifyingglass")!),
                configureVC(rootVC: FavoriteViewController(), tabBarTitle: "Favorite", viewControllerTitle: "Favorite cocktails", image: UIImage(systemName: "heart")!)
            ],
            animated: true)
    }
    
    private func configureVC(rootVC: UIViewController, tabBarTitle: String, viewControllerTitle: String, image: UIImage) -> UIViewController {
        let vc = UINavigationController(rootViewController: rootVC)
        vc.title = title
        vc.topViewController?.title = viewControllerTitle
        vc.navigationBar.prefersLargeTitles = true
        vc.tabBarItem.image = image
        return vc
    }

}
