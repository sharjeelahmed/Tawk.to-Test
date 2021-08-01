//
//  UserInfoViewController.swift
//  TawkDeveloperTest
//
//  Created by Shairjeel Ahmed on 30/07/2021.
//

import UIKit

class UserInfoViewController: BaseViewController {
	
	@IBOutlet weak var userProfileImageView:UIImageView?
	@IBOutlet weak var userNameLabel: UILabel?
	@IBOutlet weak var CompanyLabel:UILabel?
	@IBOutlet weak var BlogLabel:UILabel?
	@IBOutlet weak var follwersLabel:UILabel?
	@IBOutlet weak var followingLabel:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	@objc override func dismissKeyboard() {
		view.endEditing(true)
		self.parent?.view?.endEditing(true)
	}
	
	func setData(user:GithubUser){
	
		if let url = URL(string:user.avatarUrl ?? ""){
			self.userProfileImageView?.load(url: url)
		}
		self.userNameLabel?.attributedText = self.getUserName(userName: user.login ?? "N/A")
		self.BlogLabel?.attributedText = self.getBlog(blog: user.blog ?? "N/A")
		self.follwersLabel?.attributedText = self.getFollowers(followers: user.followers ?? 0)
		self.followingLabel?.attributedText = self.getFollowing(following: user.following ?? 0)
		self.BlogLabel?.attributedText = self.getBlog(blog: user.blog ?? "N/A")
		self.CompanyLabel?.attributedText = self.getCompanyName(companyName: user.company ?? "N/A")
	}
	
	func getFollowers(followers:Int)->NSMutableAttributedString{
		let title = NSAttributedString.init(string: "Followers: " + String(followers) , attributes: self.getAttributeForTitle())
		let detail = NSAttributedString.init(string: "53", attributes: self.getAttributeForDetail())
		let attributedText = NSMutableAttributedString()
		attributedText.append(title)
		attributedText.append(detail)
		return attributedText
	}
	
	func getFollowing(following:Int)->NSMutableAttributedString{
		let title = NSAttributedString.init(string: "Following: " + String(following), attributes: self.getAttributeForTitle())
		let detail = NSAttributedString.init(string: "415", attributes: self.getAttributeForDetail())
		let attributedText = NSMutableAttributedString()
		attributedText.append(title)
		attributedText.append(detail)
		return attributedText
	}
	
	func getUserName(userName:String)->NSMutableAttributedString{
		let title = NSAttributedString.init(string: "name: " + userName, attributes: self.getAttributeForTitle())
		let detail = NSAttributedString.init(string: "john", attributes: self.getAttributeForDetail())
		let attributedText = NSMutableAttributedString()
		attributedText.append(title)
		attributedText.append(detail)
		return attributedText
	}
	
	func getCompanyName(companyName:String)->NSMutableAttributedString{
		let title = NSAttributedString.init(string: "company: " + companyName, attributes: self.getAttributeForTitle())
		let detail = NSAttributedString.init(string: "Apple", attributes: self.getAttributeForDetail())
		let attributedText = NSMutableAttributedString()
		attributedText.append(title)
		attributedText.append(detail)
		return attributedText
	}
	
	func getBlog(blog:String)->NSMutableAttributedString{
		let title = NSAttributedString.init(string: "blog: " + blog , attributes: self.getAttributeForTitle())
		let detail = NSAttributedString.init(string: "www.apple.com", attributes: self.getAttributeForDetail())
		let attributedText = NSMutableAttributedString()
		attributedText.append(title)
		attributedText.append(detail)
		return attributedText
	}
	
	private func getAttributeForTitle()-> [NSAttributedString.Key: Any]{
		let attributes: [NSAttributedString.Key: Any] = [
			.font:  UIFont.boldSystemFont(ofSize: 14),
			.foregroundColor: UIColor.black
		]
		return attributes
	}
	
	private func getAttributeForDetail()->[NSAttributedString.Key: Any]{
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 14),
			.foregroundColor: UIColor.black
		]
		return attributes
	}
	
	


}

