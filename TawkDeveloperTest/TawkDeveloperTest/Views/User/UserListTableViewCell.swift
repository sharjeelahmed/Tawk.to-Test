//
//  UserListTableViewCell.swift
//  TawkDeveloperTest
//
//  Created by Shairjeel Ahmed on 29/07/2021.
//

import UIKit

class UserListTableViewCell: UITableViewCell , Configurable {

	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var userDetailLabel:UILabel?
	@IBOutlet weak var userImageView:UIImageView?
	@IBOutlet weak var userImageViewContainer:UIView?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code\
		
		self.setViewContent()
		
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		//self.userImageView?.image = nil
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	var model: GithubUser?
	
	func configure(withModel user: GithubUser) {
		self.model = user
		self.userNameLabel?.text = user.login ?? "N/A"
		self.userDetailLabel?.text = user.login ?? "N/A"
		if let url = URL(string:user.avatarUrl ?? ""){
			self.userImageView?.load(url: url)
		  }
	}
	
	func setViewContent(){
		self.setUserContainerView()
	}
	
	
	
	private func setUserContainerView(){
		userImageViewContainer?.layer.borderWidth = 1
		userImageViewContainer?.layer.borderColor = UIColor.black.cgColor
		userImageViewContainer?.clipsToBounds = true
		userImageViewContainer?.layer.cornerRadius = (userImageView?.frame.size.height ?? 2) / 2
		
	}
	
	func populateData(user:GithubUser){
		self.userNameLabel?.text = user.login ?? "N/A"
		self.userDetailLabel?.text = user.login ?? "N/A"
		if let url = URL(string:user.avatarUrl ?? ""){
			self.userImageView?.load(url: url)
		  }
	}
    
}

