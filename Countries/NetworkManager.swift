//
//  NetworkManager.swift
//  Countries
//
//  Created by Asaf Baibekov on 16/10/2019.
//  Copyright © 2019 Asaf Baibekov. All rights reserved.
//

import Foundation

class NetworkManager {

	static let shared = NetworkManager()

	let countriesURL: String

	private init() {
		self.countriesURL = "https://restcountries.eu/rest/v2/all"
	}
}
