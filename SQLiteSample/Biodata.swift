//
//  Biodata.swift
//  SQLiteSample
//
//  Created by Agus Cahyono on 7/7/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import UIKit

class Biodata: SQLTable {
	
	var id = -1
	var name = ""
	var email = ""
	var alamat = ""
	
	override var description: String {
		return "id: \(id), name: \(name), email: \(email), alamat: \(alamat)"
	}
	
}
