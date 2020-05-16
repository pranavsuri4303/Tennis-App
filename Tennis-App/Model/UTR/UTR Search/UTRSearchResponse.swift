//
//  UTRSearchResponse.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 15/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation

struct UTRSearchResponse: Decodable {
	let total: Int
	let hits: [Players]
	enum CodingKeys: String, CodingKey{
		case total = "total"
		case hits = "hits"
	}
}

struct Players : Decodable {
	let id: Int
	let displayName: String
	let gender: String
	let nationality: String
	let singlesUTR: Float
	enum CodingKeys: String, CodingKey{
		case id = "id"
		case displayName = "displayName"
		case gender = "gender"
		case nationality = "nationallity"
		case singlesUTR = "singlesUTR"
	}
}
