//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Asaf Baibekov on 16/10/2019.
//  Copyright © 2019 Asaf Baibekov. All rights reserved.
//

import UIKit

class CountriesViewModel {

	private var countries: [CountryModel]
	private var filteredCountries: [CountryModel]
	private(set) var rows: Int

	var onComplete: (() -> Void)?

	init() {
		self.countries = [CountryModel]()
		self.filteredCountries = [CountryModel]()
		self.rows = countries.count
	}
}

extension CountriesViewModel {
	func fetch() {
		NetworkManager.shared.fetchCountries(
			completion: { [weak self] result in
				switch result {
				case .success(let countries):
					self?.countries = countries
					self?.rows = countries.count
					self?.onComplete?()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		)
	}
}

extension CountriesViewModel {
	func updateSearchResults(for searchController: UISearchController) {
		guard let text = searchController.searchBar.text, !text.isEmpty else { return }
		self.filteredCountries = self.countries.filter { $0.name.lowercased().contains(text.lowercased()) || $0.nativeName.lowercased().contains(text.lowercased()) }
		self.rows = self.filteredCountries.isEmpty ? countries.count : filteredCountries.count
		self.onComplete?()
	}
	func reset() {
		self.filteredCountries.removeAll()
		self.rows = countries.count
		self.onComplete?()
	}
}

extension CountriesViewModel {
	func getCountryModel(by indexPath: IndexPath) -> CountryModel {
		return (self.filteredCountries.isEmpty ? self.countries : self.filteredCountries)[indexPath.row]
	}
	func getName(by indexPath: IndexPath) -> String {
		return self.getCountryModel(by: indexPath).name
	}
	func getNativeName(by indexPath: IndexPath) -> String {
		return self.getCountryModel(by: indexPath).nativeName
	}
	func getBorders(by indexPath: IndexPath) -> [String] {
		return self.getCountryModel(by: indexPath).borders
	}
	func getArea(by indexPath: IndexPath) -> Double? {
		return self.getCountryModel(by: indexPath).area
	}
}
