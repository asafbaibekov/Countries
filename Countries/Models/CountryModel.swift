//
//  CountryModel.swift
//  Countries
//
//  Created by Asaf Baibekov on 16/10/2019.
//  Copyright © 2019 Asaf Baibekov. All rights reserved.
//

import Foundation

struct CountryModel: Decodable {

	let name: String
	let nativeName: String
	let borders: [String]
	let area: Double?

}
