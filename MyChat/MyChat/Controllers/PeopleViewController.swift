//
//  PeopleViewController.swift
//  MyChat
//
//  Created by Иван Незговоров on 29.04.2024.
//

import Foundation
import UIKit

class PeopleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        setupSearchBar()
    }
}

private extension PeopleViewController {
    func setupSearchBar() {
      //  navigationController?.navigationBar.barTintColor = .mainWhite()
      //  navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
}
// MARK: -- UISearchBarDelegate
extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


#Preview("MainTabBarController"){
    MainTabBarController()
}
