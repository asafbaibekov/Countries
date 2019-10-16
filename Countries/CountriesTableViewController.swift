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

	override func viewDidLoad() {
		super.viewDidLoad()
		self.clearsSelectionOnViewWillAppear = false
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
		let name = self.viewModel.getName(by: indexPath)
		let nativeName = self.viewModel.getNativeName(by: indexPath)
		cell.textLabel?.text = name == nativeName ? self.viewModel.getName(by: indexPath) : "\(self.viewModel.getName(by: indexPath))\n\(self.viewModel.getNativeName(by: indexPath))"
		if let area = self.viewModel.getArea(by: indexPath) {
			let formatter = NumberFormatter()
			formatter.maximumFractionDigits = 2
			cell.detailTextLabel?.text = "area: \(formatter.string(from: NSNumber(floatLiteral: area))!)"
		} else {
			cell.detailTextLabel?.text = nil
		}
		return cell
	}
}
