//
//  CountriesTableViewController.swift
//  Countries
//
//  Created by Asaf Baibekov on 16/10/2019.
//  Copyright © 2019 Asaf Baibekov. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {

	let viewModel = CountriesViewModel()

	lazy var searchController: UISearchController = {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search Country"
		searchController.searchBar.scopeButtonTitles = ["Name ASC", "Name DESC", "Area ASC", "Area DESC"]
		searchController.searchBar.showsScopeBar = true
		searchController.searchBar.delegate = self
		return searchController
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.clearsSelectionOnViewWillAppear = true
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true
		self.viewModel.onComplete = {
			self.tableView.reloadData()
		}
		self.viewModel.fetch()
	}

}

extension CountriesTableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.rows
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.numberOfLines = 0
		let name = self.viewModel.getName(at: indexPath)
		let nativeName = self.viewModel.getNativeName(at: indexPath)
		cell.textLabel?.text = name == nativeName ? self.viewModel.getName(at: indexPath) : "\(self.viewModel.getName(at: indexPath))\n\(self.viewModel.getNativeName(at: indexPath))"
		if let area = self.viewModel.getArea(at: indexPath) {
			let formatter = NumberFormatter()
			formatter.maximumFractionDigits = 2
			cell.detailTextLabel?.text = "area: \(formatter.string(from: NSNumber(floatLiteral: area))!)"
		} else {
			cell.detailTextLabel?.text = nil
		}
		return cell
	}
}

extension CountriesTableViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let bordersTVC = BordersTableViewController(style: .plain)
		bordersTVC.viewModel = self.viewModel.getBordersViewModel(at: indexPath)
		self.navigationController?.pushViewController(bordersTVC, animated: true)
	}
}

extension CountriesTableViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		self.viewModel.updateSearchResults(for: searchController)
	}
}

extension CountriesTableViewController: UISearchBarDelegate {
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.viewModel.reset()
	}
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		self.viewModel.selectedScopeButtonIndexDidChange(selectedScope)
	}
}
