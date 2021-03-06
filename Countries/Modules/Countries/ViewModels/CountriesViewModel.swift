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
		self.selectedScopeButtonIndexDidChange(0)
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
	func selectedScopeButtonIndexDidChange(_ selectedScope: Int) {
		switch selectedScope {
		case 0: self.countries.sort(by: { $0.name < $1.name })
		case 1: self.countries.sort(by: { $0.name > $1.name })
		case 2: self.countries.sort(by: { $0.area ?? 0 < $1.area ?? 0 })
		case 3: self.countries.sort(by: { $0.area ?? 0 > $1.area ?? 0 })
		default: break
		}
		self.onComplete?()
	}
	func reset() {
		self.filteredCountries.removeAll()
		self.rows = countries.count
		self.onComplete?()
	}
}

extension CountriesViewModel {
	func getBordersViewModel(at indexPath: IndexPath) -> BordersViewModel {
		let country = self.getCountry(at: indexPath)
		let borderedCountries = country.borders.map { border in countries.first { border == $0.alpha3Code }! }
		return BordersViewModel(country: country, borderedCountries: borderedCountries)
	}
	func getTitle(at indexPath: IndexPath) -> String? {
		let name = self.getCountry(at: indexPath).name
		let nativeName = self.getCountry(at: indexPath).nativeName
		return name == nativeName ? name : "\(name)\n\(nativeName)"
	}
	func getSubtitle(at indexPath: IndexPath) -> String? {
		guard let area = self.getCountry(at: indexPath).area else { return nil }
		let formatter = NumberFormatter()
		formatter.maximumFractionDigits = 2
		return "area: \(formatter.string(from: NSNumber(floatLiteral: area))!)"
	}
}

private extension CountriesViewModel {
	func getCountry(at indexPath: IndexPath) -> CountryModel {
		return (self.filteredCountries.isEmpty ? self.countries : self.filteredCountries)[indexPath.row]
	}
}
