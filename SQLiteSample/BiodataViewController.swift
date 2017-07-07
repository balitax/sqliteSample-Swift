//
//  ViewController.swift
//  SQLiteSample
//
//  Created by Agus Cahyono on 7/7/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	
	var data = [Biodata]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.dataSource = self
		self.tableView.delegate = self
		
		self.tableView.estimatedRowHeight = 60
		self.tableView.rowHeight = UITableViewAutomaticDimension
		
		
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		data = Biodata.rows(order: "ID DESC") as! [Biodata]
		print("BIODATA \(data)")
		self.tableView.reloadData()
		
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "biodata", for: indexPath)
		
		let name = cell.viewWithTag(1) as! UILabel
		let email = cell.viewWithTag(2) as! UILabel
		let alamat = cell.viewWithTag(3) as! UILabel
		
		let biodata = data[indexPath.row]
		
		name.text = biodata.name
		email.text = biodata.email
		alamat.text = biodata.alamat
		
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let editData = self.storyboard?.instantiateViewController(withIdentifier: "TambahBiodataViewController") as! TambahBiodataViewController
		
		editData.statusForm = .edit
		editData.editName = data[indexPath.row].name
		editData.editEmail = data[indexPath.row].email
		editData.editAlamat = data[indexPath.row].alamat
		editData.editId = data[indexPath.row].id
		
		self.navigationController?.pushViewController(editData, animated: true)
		
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		
		if (editingStyle == UITableViewCellEditingStyle.delete) {
			print("hapus")
			
			let id = data[indexPath.row].id
			self.hapusData(id: id)
			self.tableView.reloadData()
		}
		
		
		self.tableView.reloadData()
		
	}
	

	func hapusData(id: Int) {
		
		if let deleteData = Biodata.rowBy(id: id) as? Biodata {
			_ = deleteData.delete()
			NSLog("Deleted category with ID = \(id)")
		}
		
		data = Biodata.rows(order: "ID DESC") as! [Biodata]
		
		self.tableView.reloadData()
		
	}


}


