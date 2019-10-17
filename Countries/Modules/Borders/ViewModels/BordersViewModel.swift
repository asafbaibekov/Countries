//
//  BordersViewModel.swift
//  Countries
//
//  Created by Asaf Baibekov on 17/10/2019.
//  Copyright © 2019 Asaf Baibekov. All rights reserved.
//

import UIKit

class BordersViewModel {

	let country: CountryModel
	let borderedCountries: [CountryModel]
	let rows: Int
	let sections: Int
	let title: String

	init(country: CountryModel, borderedCountries: [CountryModel]) {
		self.country = country
		self.borderedCountries = borderedCountries.sorted(by: { $0.name < $1.name })
		self.rows = borderedCountries.count
		self.sections = 2
		self.title = "Borders of \(country.name)"
	}

}

extension BordersViewModel {
	func getHeaderTitle(for section: Int) -> String? {
		switch section {
		case 0: return "Names"
		case 1: return "Native names"
		default: return nil
		}
	}
	func getTitle(at indexPath: IndexPath) -> String? {
		switch indexPath.section {
		case 0: return getBorderedCountry(at: indexPath).name
		case 1: return getBorderedCountry(at: indexPath).nativeName
		default: return nil
		}
	}
	func getSubtitle(at indexPath: IndexPath) -> String? {
		guard let area = self.getBorderedCountry(at: indexPath).area else { return nil }
		let formatter = NumberFormatter()
		formatter.maximumFractionDigits = 2
		return "area: \(formatter.string(from: NSNumber(floatLiteral: area))!)"
	}
}

private extension BordersViewModel {
	func getBorderedCountry(at indexPath: IndexPath) -> CountryModel {
		return self.borderedCountries[indexPath.row]
	}
}
