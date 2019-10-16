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

	func fetchCountries(completion: @escaping (Result<[CountryModel], Error>) -> Void) {
		let url = URL(string: countriesURL)!
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			DispatchQueue.main.async {
				if let error = error {
					completion(.failure(error))
				} else if let data = data {
					do {
						completion(.success(try JSONDecoder().decode([CountryModel].self, from: data)))
					} catch {
						completion(.failure(error))
					}
				}
			}
		}.resume()
	}
}
