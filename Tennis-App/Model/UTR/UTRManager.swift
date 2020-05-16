//
//  UTRManager.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 6/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation
protocol UTRManagerDelegate {
	func didUpdateUtrProfile(profile: UTRProfile)
	func didFailWithError(error: Error!)
}

struct UTRManager {

	var delegate: UTRManagerDelegate?

	// Fetch Profile for specific user with ID
	func fetchProfile(withID ID: String){
		let url = "https://app.myutr.com/api/v1/player/\(ID)"
		performRequest(with: url)
	}

	func fetchSearch(withName Name: String){
		let url = "https://www.myutr.com/api/v2/search/players?query=\(Name)"
		performRequest(with: url)
	} 

	func performRequest(with url: String){
		if let URL = URL(string: url){
			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: URL) { (data, response, err) in
				if err != nil{
					print("Err")
					return
				}
				if let userData = data {
					if let data = self.parseJSON(userData){
						self.delegate?.didUpdateUtrProfile(profile: data)
					}
				}
			}
			task.resume()
//			switch request {
//			case "Profile":
//
//			case "Search":
//				let task = session.dataTask(with: URL) { (data, response, err) in
//					if err != nil{
//						print("Err")
//						return
//					}
//					if let userData = data {
//						if let data = self.parseJSON1(userData){
//							self.delegate?.didUpdateUtrProfile(profile: data)
//						}
//					}
//				}
//				task.resume()
//			default:
//				return
//			}
		}
	}
//	func parseJSON2(_ userData: Data)-> UTRSearch?{
//		let decoder = JSONDecoder()
//		do {
//			let player = try decoder.decode(UTRSearch.self, from: userData)
//			return UTRSearch(total: player.total, results: player.hits)
//		} catch {
//			self.delegate?.didFailWithError(error: error)
//			return nil
//		}
//	}

	func parseJSON(_ userData: Data)-> UTRProfile?{
		let decoder = JSONDecoder()
		do {
			let user = try decoder.decode(UTRProfileResponse.self, from: userData)
			let name = "\(user.firstName) \(user.lastName)"
			return UTRProfile(name: name,
							  singles: user.singlesUtr,
							  singlesStatus: user.ratingStatusSingles,
							  singlesProgress: user.ratingProgressSingles,
							  doubles: user.doublesUtr,
							  doublesStatus: user.ratingStatusDoubles,
							  doublesProgress: user.ratingProgressDoubles,
							  nationality: user.nationality)
		} catch {
			self.delegate?.didFailWithError(error: error)
			return nil
		}
	}

	
}
