//
//  TambahBiodataViewController.swift
//  SQLiteSample
//
//  Created by Agus Cahyono on 7/7/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import UIKit

enum form {
	case baru
	case edit
}

class TambahBiodataViewController: UIViewController {

	@IBOutlet weak var name: FloatLabelTextField!
	@IBOutlet weak var email: FloatLabelTextField!
	@IBOutlet weak var alamat: FloatLabelTextField!
	@IBOutlet weak var buttonAksi: UIButton!
	
	var snackBar = TTGSnackbar()
	var statusForm = form.baru
	
	var editName = ""
	var editEmail = ""
	var editAlamat = ""
	var editId = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if statusForm == .edit {
			
			name.text = editName
			email.text = editEmail
			alamat.text = editAlamat
			
			self.buttonAksi.setTitle("EDIT", for: .normal)
			
		}
		
    }
	
	@IBAction func aksiSimpan(_ sender: UIButton) {
		
		if (name.text?.isEmpty)! {
			snackBar = TTGSnackbar(message: "Masukan nama anda", duration: .middle)
			snackBar.show()
		} else if (email.text?.isEmpty)! {
			snackBar = TTGSnackbar(message: "Masukan email anda", duration: .middle)
			snackBar.show()
		} else if (alamat.text?.isEmpty)! {
			snackBar = TTGSnackbar(message: "Masukan alamat anda", duration: .middle)
			snackBar.show()
		} else {
			
			let biodata = Biodata()
			
			biodata.name = name.text!
			biodata.email = email.text!
			biodata.alamat = alamat.text!
			
			
			if statusForm == .edit {
				
				
				biodata.id 	= editId
				
				if biodata.update() != 0 {
					
					snackBar = TTGSnackbar(message: "Data berhasil diperbarui", duration: .middle)
					snackBar.show()
					
					DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
						self.navigationController?.popViewController(animated: true)
					})
					
				}

			} else {
				if biodata.save() != 0 {
					
					snackBar = TTGSnackbar(message: "Data berhasil disimpan", duration: .middle)
					snackBar.show()
					
					DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
						self.navigationController?.popViewController(animated: true)
					})
					
				}
			}
			
		}
		
		
		self.view.endEditing(true)
		
	}
	

}
