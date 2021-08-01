//
//  UserListViewController.swift
//  TawkDeveloperTest
//
//  Created by Shairjeel Ahmed on 29/07/2021.
//

import UIKit
import CoreData


class UserListViewController: BaseViewController {
	
	@IBOutlet weak var tableView:UITableView?
	var array:[GithubUser] = Array()
	var filteredArray:[GithubUser] = Array()
	
	var isFiltering: Bool {
	  return searchController.isActive && !isSearchBarEmpty
	}
	var reachability = try! Reachability()
	
	var isSearchBarEmpty: Bool {
	  return searchController.searchBar.text?.isEmpty ?? true
	}

	var since:Int = 0
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Github Users"
		setupNavigationBar()
		self.registerNib()
		self.simpleGetUrlRequestWithErrorHandling(since: 0)
		setUpReachability()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tableView?.reloadData()
	}
	
	private lazy var searchController: UISearchController = {
		let sc = UISearchController(searchResultsController: nil)
		sc.searchResultsUpdater = self
		sc.delegate = self
		sc.obscuresBackgroundDuringPresentation = false
		sc.searchBar.placeholder = "Enter User Name"
		sc.searchBar.autocapitalizationType = .allCharacters
		return sc
	}()
	
	private func setupNavigationBar() {
		navigationItem.searchController = searchController
	}
	
	private func registerNib(){
		let nib = UINib.init(nibName: UserListTableViewCell.identifier, bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: UserListTableViewCell.identifier)
		
		let nib2 = UINib.init(nibName: NotesTableViewCell.identifier, bundle: nil)
		self.tableView?.register(nib2, forCellReuseIdentifier: NotesTableViewCell.identifier)
		
		let nib3 = UINib.init(nibName: InvertedUserTableViewCell.identifier, bundle: nil)
		self.tableView?.register(nib3, forCellReuseIdentifier: InvertedUserTableViewCell.identifier)
	}
	
	func setUpReachability()
	   {
		   //declare this property where it won't go out of scope relative to your listener
		   DispatchQueue.main.async {

			   self.reachability.whenReachable = { reachability in
			   if reachability.connection == .wifi {
				   self.simpleGetUrlRequestWithErrorHandling(since: 0)
				   print("Reachable via WiFi")
			   } else {
				   self.simpleGetUrlRequestWithErrorHandling(since: 0)
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
	
	func navigateToDetailVc(user: GithubUser) {
		 let vc = AppStoryboard.Main.instance.instantiateViewController(identifier: BaseUserDetailViewController.identifier, creator: { coder in
			return BaseUserDetailViewController(coder: coder, selectedUser: user)
		})

		navigationController?.pushViewController(vc, animated: true)
	}
	
	private func filterContentForSearchText(_ searchText: String) {
		self.filteredArray = self.array.filter{$0.login?.contains(searchText.lowercased()) ?? false}
		self.tableView?.reloadData()
	  }

	func simpleGetUrlRequestWithErrorHandling(since:Int)
	{
		if !ConnectionManager.sharedInstance.hasConnectivity(){
			self.dispLayError()
			return
		}
		let session = URLSession.shared
		let str = "https://api.github.com/users?since=\(since)"
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
					self.array.append(contentsOf: swiftyJson.arrayValue.map{GithubUser.init(object: $0)})
					self.array.filter {$0.id == 2}.first?.notes = "asd"
					self.array.filter {$0.id == 5}.first?.notes = "asd"

					DispatchQueue.main.async {
						self.tableView?.reloadData()
					}
				}
			} catch {
				print("JSON error: \(error.localizedDescription)")
			}
			
		}
		task.resume()
	}
}

extension UserListViewController:UITableViewDelegate,UITableViewDataSource{
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isFiltering{
			return self.filteredArray.count
		}
		return self.array.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		/*if let cell  = tableView.dequeueReusableCell(withIdentifier: String(describing: UserListTableViewCell.self)) as? UserListTableViewCell{
			let user = isFiltering == true ? self.filteredArray[indexPath.row] :  self.array[indexPath.row]
			cell.populateData(user: user)
			if indexPath.row % 4 == 0{
				cell.userImageView?.transform = CGAffineTransform(scaleX: 1, y: -1);
			}
			
			return cell
		}*/
		
		let model = self.array[indexPath.row]
		return model.cellForTableView(tableView: tableView, atIndexPath: indexPath)
		
		//return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if !isFiltering{
			self.tableView?.tableFooterView?.isHidden = false
			tableView.addLoading(indexPath) {
				self.since += 30
				self.simpleGetUrlRequestWithErrorHandling(since: self.since)
				self.tableView?.reloadData()
				tableView.stopLoading() // stop your indicator
			}
		}else{
			self.tableView?.tableFooterView?.isHidden = true
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let user = isFiltering == true ? self.filteredArray[indexPath.row] :  self.array[indexPath.row]
		self.navigateToDetailVc(user:user)
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
	}
}
extension UserListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		guard let text = searchController.searchBar.text else { return }
		self.filterContentForSearchText(text)
	}
}


