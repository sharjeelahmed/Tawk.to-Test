//
//  GithubUser.swift
//
//  Created by Shairjeel Ahmed on 01/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class GithubUser: NSCoding , TableViewCompatible {
	
	// MARK: Declaration for string constants to be used to decode and also serialize.
	private struct SerializationKeys {
		static let publicRepos = "public_repos"
		static let organizationsUrl = "organizations_url"
		static let reposUrl = "repos_url"
		static let starredUrl = "starred_url"
		static let type = "type"
		static let gistsUrl = "gists_url"
		static let followersUrl = "followers_url"
		static let id = "id"
		static let blog = "blog"
		static let followers = "followers"
		static let following = "following"
		static let company = "company"
		static let url = "url"
		static let updatedAt = "updated_at"
		static let publicGists = "public_gists"
		static let siteAdmin = "site_admin"
		static let gravatarId = "gravatar_id"
		static let htmlUrl = "html_url"
		static let avatarUrl = "avatar_url"
		static let login = "login"
		static let createdAt = "created_at"
		static let subscriptionsUrl = "subscriptions_url"
		static let followingUrl = "following_url"
		static let receivedEventsUrl = "received_events_url"
		static let eventsUrl = "events_url"
		static let nodeId = "node_id"
	}
	
	// MARK: Properties
	public var publicRepos: Int?
	public var organizationsUrl: String?
	public var reposUrl: String?
	public var starredUrl: String?
	public var type: String?
	public var gistsUrl: String?
	public var followersUrl: String?
	public var id: Int?
	public var blog: String?
	public var followers: Int?
	public var following: Int?
	public var company: String?
	public var url: String?
	public var updatedAt: String?
	public var publicGists: Int?
	public var siteAdmin: Bool? = false
	public var gravatarId: String?
	public var htmlUrl: String?
	public var avatarUrl: String?
	public var login: String?
	public var createdAt: String?
	public var subscriptionsUrl: String?
	public var followingUrl: String?
	public var receivedEventsUrl: String?
	public var eventsUrl: String?
	public var nodeId: String?
	public var notes: String?
	
	
	
	func getReuseIdentifier(indexPath:IndexPath)->String{
		if indexPath.row % 4 == 0{
			return InvertedUserTableViewCell.identifier
		}else if self.notes != nil{
			return NotesTableViewCell.identifier
		}else {
			return UserListTableViewCell.identifier
		}
	}
	
	func getCell(tableView: UITableView, atIndexPath indexPath: IndexPath)->UITableViewCell{
		if indexPath.row % 4 == 0{
			let cell = tableView.dequeueReusableCell(withIdentifier: InvertedUserTableViewCell.identifier, for: indexPath) as! InvertedUserTableViewCell
			return cell
		}else if self.notes != nil{
			let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier, for: indexPath) as! NotesTableViewCell
			return cell
		}
		else {
			let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.identifier, for: indexPath) as! UserListTableViewCell
			return cell
		}
	}
	
	public func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
		let cell = self.getCell(tableView: tableView, atIndexPath: indexPath)
		if let invertedCell = cell as? InvertedUserTableViewCell{
			invertedCell.configure(withModel: self)
		}
		if let notesCell = cell as? NotesTableViewCell{
			notesCell.configure(withModel: self)
		}
		if let userCell = cell as? UserListTableViewCell{
			userCell.configure(withModel: self)
		}
		
		return cell
		
	}
	
	// MARK: SwiftyJSON Initializers
	/// Initiates the instance based on the object.
	///
	/// - parameter object: The object of either Dictionary or Array kind that was passed.
	/// - returns: An initialized instance of the class.
	public convenience init(object: Any) {
		self.init(json: JSON(object))
	}
	
	/// Initiates the instance based on the JSON that was passed.
	///
	/// - parameter json: JSON object from SwiftyJSON.
	public required init(json: JSON) {
		publicRepos = json[SerializationKeys.publicRepos].int
		organizationsUrl = json[SerializationKeys.organizationsUrl].string
		reposUrl = json[SerializationKeys.reposUrl].string
		starredUrl = json[SerializationKeys.starredUrl].string
		type = json[SerializationKeys.type].string
		gistsUrl = json[SerializationKeys.gistsUrl].string
		followersUrl = json[SerializationKeys.followersUrl].string
		id = json[SerializationKeys.id].int
		blog = json[SerializationKeys.blog].string
		followers = json[SerializationKeys.followers].int
		following = json[SerializationKeys.following].int
		company = json[SerializationKeys.company].string
		url = json[SerializationKeys.url].string
		updatedAt = json[SerializationKeys.updatedAt].string
		publicGists = json[SerializationKeys.publicGists].int
		siteAdmin = json[SerializationKeys.siteAdmin].boolValue
		gravatarId = json[SerializationKeys.gravatarId].string
		htmlUrl = json[SerializationKeys.htmlUrl].string
		avatarUrl = json[SerializationKeys.avatarUrl].string
		login = json[SerializationKeys.login].string
		createdAt = json[SerializationKeys.createdAt].string
		subscriptionsUrl = json[SerializationKeys.subscriptionsUrl].string
		followingUrl = json[SerializationKeys.followingUrl].string
		receivedEventsUrl = json[SerializationKeys.receivedEventsUrl].string
		eventsUrl = json[SerializationKeys.eventsUrl].string
		nodeId = json[SerializationKeys.nodeId].string
	}
	
	/// Generates description of the object in the form of a NSDictionary.
	///
	/// - returns: A Key value pair containing all valid values in the object.
	public func dictionaryRepresentation() -> [String: Any] {
		var dictionary: [String: Any] = [:]
		if let value = publicRepos { dictionary[SerializationKeys.publicRepos] = value }
		if let value = organizationsUrl { dictionary[SerializationKeys.organizationsUrl] = value }
		if let value = reposUrl { dictionary[SerializationKeys.reposUrl] = value }
		if let value = starredUrl { dictionary[SerializationKeys.starredUrl] = value }
		if let value = type { dictionary[SerializationKeys.type] = value }
		if let value = gistsUrl { dictionary[SerializationKeys.gistsUrl] = value }
		if let value = followersUrl { dictionary[SerializationKeys.followersUrl] = value }
		if let value = id { dictionary[SerializationKeys.id] = value }
		if let value = blog { dictionary[SerializationKeys.blog] = value }
		if let value = followers { dictionary[SerializationKeys.followers] = value }
		if let value = following { dictionary[SerializationKeys.following] = value }
		if let value = company { dictionary[SerializationKeys.company] = value }
		if let value = url { dictionary[SerializationKeys.url] = value }
		if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
		if let value = publicGists { dictionary[SerializationKeys.publicGists] = value }
		dictionary[SerializationKeys.siteAdmin] = siteAdmin
		if let value = gravatarId { dictionary[SerializationKeys.gravatarId] = value }
		if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
		if let value = avatarUrl { dictionary[SerializationKeys.avatarUrl] = value }
		if let value = login { dictionary[SerializationKeys.login] = value }
		if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
		if let value = subscriptionsUrl { dictionary[SerializationKeys.subscriptionsUrl] = value }
		if let value = followingUrl { dictionary[SerializationKeys.followingUrl] = value }
		if let value = receivedEventsUrl { dictionary[SerializationKeys.receivedEventsUrl] = value }
		if let value = eventsUrl { dictionary[SerializationKeys.eventsUrl] = value }
		if let value = nodeId { dictionary[SerializationKeys.nodeId] = value }
		return dictionary
	}
	
	// MARK: NSCoding Protocol
	required public init(coder aDecoder: NSCoder) {
		self.publicRepos = aDecoder.decodeObject(forKey: SerializationKeys.publicRepos) as? Int
		self.organizationsUrl = aDecoder.decodeObject(forKey: SerializationKeys.organizationsUrl) as? String
		self.reposUrl = aDecoder.decodeObject(forKey: SerializationKeys.reposUrl) as? String
		self.starredUrl = aDecoder.decodeObject(forKey: SerializationKeys.starredUrl) as? String
		self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
		self.gistsUrl = aDecoder.decodeObject(forKey: SerializationKeys.gistsUrl) as? String
		self.followersUrl = aDecoder.decodeObject(forKey: SerializationKeys.followersUrl) as? String
		self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
		self.blog = aDecoder.decodeObject(forKey: SerializationKeys.blog) as? String
		self.followers = aDecoder.decodeObject(forKey: SerializationKeys.followers) as? Int
		self.following = aDecoder.decodeObject(forKey: SerializationKeys.following) as? Int
		self.company = aDecoder.decodeObject(forKey: SerializationKeys.company) as? String
		self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
		self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
		self.publicGists = aDecoder.decodeObject(forKey: SerializationKeys.publicGists) as? Int
		self.siteAdmin = aDecoder.decodeBool(forKey: SerializationKeys.siteAdmin)
		self.gravatarId = aDecoder.decodeObject(forKey: SerializationKeys.gravatarId) as? String
		self.htmlUrl = aDecoder.decodeObject(forKey: SerializationKeys.htmlUrl) as? String
		self.avatarUrl = aDecoder.decodeObject(forKey: SerializationKeys.avatarUrl) as? String
		self.login = aDecoder.decodeObject(forKey: SerializationKeys.login) as? String
		self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
		self.subscriptionsUrl = aDecoder.decodeObject(forKey: SerializationKeys.subscriptionsUrl) as? String
		self.followingUrl = aDecoder.decodeObject(forKey: SerializationKeys.followingUrl) as? String
		self.receivedEventsUrl = aDecoder.decodeObject(forKey: SerializationKeys.receivedEventsUrl) as? String
		self.eventsUrl = aDecoder.decodeObject(forKey: SerializationKeys.eventsUrl) as? String
		self.nodeId = aDecoder.decodeObject(forKey: SerializationKeys.nodeId) as? String
	}
	
	public func encode(with aCoder: NSCoder) {
		aCoder.encode(publicRepos, forKey: SerializationKeys.publicRepos)
		aCoder.encode(organizationsUrl, forKey: SerializationKeys.organizationsUrl)
		aCoder.encode(reposUrl, forKey: SerializationKeys.reposUrl)
		aCoder.encode(starredUrl, forKey: SerializationKeys.starredUrl)
		aCoder.encode(type, forKey: SerializationKeys.type)
		aCoder.encode(gistsUrl, forKey: SerializationKeys.gistsUrl)
		aCoder.encode(followersUrl, forKey: SerializationKeys.followersUrl)
		aCoder.encode(id, forKey: SerializationKeys.id)
		aCoder.encode(blog, forKey: SerializationKeys.blog)
		aCoder.encode(followers, forKey: SerializationKeys.followers)
		aCoder.encode(following, forKey: SerializationKeys.following)
		aCoder.encode(company, forKey: SerializationKeys.company)
		aCoder.encode(url, forKey: SerializationKeys.url)
		aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
		aCoder.encode(publicGists, forKey: SerializationKeys.publicGists)
		aCoder.encode(siteAdmin, forKey: SerializationKeys.siteAdmin)
		aCoder.encode(gravatarId, forKey: SerializationKeys.gravatarId)
		aCoder.encode(htmlUrl, forKey: SerializationKeys.htmlUrl)
		aCoder.encode(avatarUrl, forKey: SerializationKeys.avatarUrl)
		aCoder.encode(login, forKey: SerializationKeys.login)
		aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
		aCoder.encode(subscriptionsUrl, forKey: SerializationKeys.subscriptionsUrl)
		aCoder.encode(followingUrl, forKey: SerializationKeys.followingUrl)
		aCoder.encode(receivedEventsUrl, forKey: SerializationKeys.receivedEventsUrl)
		aCoder.encode(eventsUrl, forKey: SerializationKeys.eventsUrl)
		aCoder.encode(nodeId, forKey: SerializationKeys.nodeId)
	}
	
}

extension GithubUser{
	func saveUserToCoreData(){
		
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		
		let managedContext = appDelegate.persistentContainer.viewContext
		
		let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
		
		let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
		
		user.setValue(self.login ?? "", forKeyPath: "username")
		user.setValue(self.id ?? 0, forKey: "id")
		user.setValue(self.followers ?? 0, forKey: "followers")
		user.setValue(self.following ?? 0, forKey: "following")
		user.setValue(self.blog ?? "", forKey: "blog")
		user.setValue(self.company ?? "", forKey: "company")
		user.setValue(self.notes ?? "", forKey: "notes")
		
		
		do {
			try managedContext.save()
			
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
	
}
