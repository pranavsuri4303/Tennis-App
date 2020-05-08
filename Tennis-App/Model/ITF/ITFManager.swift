//
//  ITFManager.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 8/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation
protocol ITFManagerDelegate {
	func didUpdateITFProfOverView(profOverview: ITFProfOverview)
	func didFailWithError(error: Error!)
}
struct ITFManager {
	var delegate: ITFManagerDelegate
}
