//
//  UTRResponse.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 6/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation

struct ProfileResponse: Decodable {
	let firstName: String
	let lastName: String

	let singlesUtr: Double
	let ratingStatusSingles: String
	let ratingProgressSingles: String

	let doublesUtr: Double
	let ratingStatusDoubles: String
	let ratingProgressDoubles: String

	let nationality: String
}
