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
	func getBorderedCountry(by indexPath: IndexPath) -> CountryModel {
		return self.borderedCountries[indexPath.row]
	}
	func getTitle(for section: Int) -> String? {
		switch section {
		case 0: return "Names"
		case 1: return "Native names"
		default: return nil
		}
	}
	func getTitle(by indexPath: IndexPath) -> String? {
		switch indexPath.section {
		case 0: return getBorderedCountry(by: indexPath).name
		case 1: return getBorderedCountry(by: indexPath).nativeName
		default: return nil
		}
	}
	func getSubtitle(by indexPath: IndexPath) -> String? {
		guard let area = self.getBorderedCountry(by: indexPath).area else { return nil }
		let formatter = NumberFormatter()
		formatter.maximumFractionDigits = 2
		return "area: \(formatter.string(from: NSNumber(floatLiteral: area))!)"
	}
}
