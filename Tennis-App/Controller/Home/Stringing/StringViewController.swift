//
//  CommunityViewController.swift
//  Tennis-App
//
//  Created by Pranav  Suri on 5/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import ProgressHUD

class StringViewController: UIViewController {
	let db = Firestore.firestore()


	@IBOutlet weak var TableView: UITableView!
	var arrStrings = [DataStrings()]

	override func viewDidLoad() {
		super.viewDidLoad()
		TableView.alpha = 0

	}
	override func viewDidAppear(_ animated: Bool) {
		showIndicator(withTitle: "Loading Stringing data.", and: "")
		let documentRef = db.collection("strings").document(Auth.auth().currentUser!.uid)
		documentRef.getDocument { (doc, err) in
			if err != nil{
				ProgressHUD.showError(err?.localizedDescription)
			} else{
				let stringHistory = doc!.data()
				if let dict = stringHistory!["stringHistory"] as? [[String:Any]] {
					self.arrStrings.removeAll()
					for data in dict {
						let dataString = DataStrings.init(json: data)
						self.arrStrings.append(dataString)
					}
					self.TableView.reloadData()
				}
				self.hideIndicator()
				UITableView.animate(withDuration: 0.5) {
					self.TableView.alpha = 1
				}
			}
		}
	}






	@IBAction func addString(_ sender: Any) {
	}

}

extension StringViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.arrStrings.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.TableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StringsTableViewCell
		let data = self.arrStrings[indexPath.row]
		print(data.racket)
		cell.lblRacket.text = "Racket Name : \(data.racket)"
		cell.lblStringName.text = "String Name : \(data.stringName)"
		cell.lblStringBrand.text = "String Brand : \(data.stringBrand)"
		cell.lblMainTension.text = "\(data.mainsTension)"
		cell.lblCrossTension.text = "\(data.crossTension)"
		return cell
	}


}
