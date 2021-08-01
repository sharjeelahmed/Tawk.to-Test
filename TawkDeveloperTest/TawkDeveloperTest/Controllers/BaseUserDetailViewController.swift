//
//  UserDetailViewController.swift
//  TawkDeveloperTest
//
//  Created by Shairjeel Ahmed on 30/07/2021.
//

import UIKit

class BaseUserDetailViewController: BaseViewController {
	
	var selectedUser:GithubUser
	
	@IBOutlet weak var scrollView:UIScrollView?
	@IBOutlet weak var notesTextView:UITextView?
	weak var userInfoVc: UserInfoViewController?
	
	var reachability = try! Reachability()
	init?(coder: NSCoder, selectedUser: GithubUser) {
		self.selectedUser = selectedUser
		super.init(coder: coder)
	}
	
	required init?(coder: NSCoder) {
		fatalError("You must create this view controller with a github user.")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = self.selectedUser.login ?? ""
		self.setUpReachability()
		self.simpleGetUrlRequestWithErrorHandling()
	}
	
	private func setUserInfoVc(){
		self.userInfoVc?.setData(user: self.selectedUser)
	}
	
	@IBAction func didTapOnSave(){
		
	}
	
	func setUpReachability()
	   {
		   //declare this property where it won't go out of scope relative to your listener
		   DispatchQueue.main.async {
			   self.reachability.whenReachable = { reachability in
			   if reachability.connection == .wifi {
				   self.simpleGetUrlRequestWithErrorHandling()
				   print("Reachable via WiFi")
			   } else {
				   self.simpleGetUrlRequestWithErrorHandling()
				   print("Reachable via Cellular")
			   }
		   }
			   self.self.reachability.whenUnreachable = { _ in
				   self.dispLayError()
			   print("Not reachable")
		   }

		   do {
			   try self.reachability.startNotifier()
		   } catch {
			   print("Unable to start notifier")
		   }

		   }
	   }
	
	
	func simpleGetUrlRequestWithErrorHandling()
	{
		if !ConnectionManager.sharedInstance.hasConnectivity(){
			self.dispLayError()
			return
		}
		let session = URLSession.shared
		let str = "https://api.github.com/users/\(self.selectedUser.login ?? "")"
		let url = URL(string: str)!
		
		let task = session.dataTask(with: url) { data, response, error in
			
			if error != nil || data == nil {
				print("Client error!")
				return
			}
			
			guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
				print("Server error!")
				return
			}
			
			guard let mime = response.mimeType, mime == "application/json" else {
				print("Wrong MIME type!")
				return
			}
			
			do {
				//let json = try JSONSerialization.jsonObject(with: data!, options: [])
				let json = try JSONSerialization.jsonObject(with: data!, options: [])
				if let swiftyJson = JSON.init(rawValue: json){
					 let user = GithubUser.init(json: swiftyJson)
					self.selectedUser = user
					DispatchQueue.main.async {
						self.setUserInfoVc()
					}
				}
			} catch {
				print("JSON error: \(error.localizedDescription)")
			}
			
		}
		task.resume()
	}
	
}

extension BaseUserDetailViewController:UITextViewDelegate{
}


extension BaseUserDetailViewController{
	
	override func performSegue(withIdentifier identifier: String, sender: Any?) {
		if shouldPerformSegue(withIdentifier: identifier, sender: sender) {
			super.performSegue(withIdentifier: identifier, sender: sender)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if let vc = segue.destination as? UserInfoViewController{
			self.userInfoVc = vc
			self.setUserInfoVc()
			vc.view.translatesAutoresizingMaskIntoConstraints = false
		}
		
	}
	
	override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
		if let identi = identifier {
			if identi == String(describing: UserInfoViewController.self) {
				//if already in the view then dont perform segue
				if children.first(where: { String(describing: $0.classForCoder) == String(describing: UserInfoViewController.self) }) != nil {
					return false
				}
			}
		}
		return true
	}
}

