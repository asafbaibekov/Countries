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
	private(set) var rows: Int

	var onComplete: (() -> Void)?

	init() {
		self.countries = [CountryModel]()
		self.rows = countries.count
	}
}

extension CountriesViewModel {
	func fetch() {
		NetworkManager.shared.fetchCountries(
			completion: { [weak self] result in
				switch result {
				case .success(let capitals):
					self?.countries = capitals
					self?.rows = capitals.count
					self?.onComplete?()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		)
	}
}

extension CountriesViewModel {
	func getCountryModel(by indexPath: IndexPath) -> CountryModel {
		return self.countries[indexPath.row]
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
