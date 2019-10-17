//
//  BordersTableViewController.swift
//  Countries
//
//  Created by Asaf Baibekov on 17/10/2019.
//  Copyright © 2019 Asaf Baibekov. All rights reserved.
//

import UIKit

class BordersTableViewController: UITableViewController {

	var viewModel: BordersViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = self.viewModel.title
		self.tableView.allowsSelection = false
	}

}

extension BordersTableViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return self.viewModel.sections
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.rows
	}
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return self.viewModel.getHeaderTitle(for: section)
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell = {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") { return cell }
			return UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        }()
		cell.textLabel?.text = self.viewModel.getTitle(at: indexPath)
		cell.detailTextLabel?.text = self.viewModel.getSubtitle(at: indexPath)
		return cell
	}
}
