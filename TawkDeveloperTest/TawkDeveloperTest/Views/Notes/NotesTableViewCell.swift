//
//  NotesTableViewCell.swift
//  TawkDeveloperTest
//
//  Created by Shairjeel Ahmed on 01/08/2021.
//

import UIKit

class NotesTableViewCell: UITableViewCell , Configurable {
	
	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var userDetailLabel:UILabel?
	@IBOutlet weak var userImageView:UIImageView?
	@IBOutlet weak var notesImageView:UIImageView?
	@IBOutlet weak var userImageViewContainer:UIView?
	

    override func awakeFromNib() {
        super.awakeFromNib()
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
	
	
	func populateData(user:GithubUser){
		self.userNameLabel?.text = user.login ?? "N/A"
		self.userDetailLabel?.text = user.login ?? "N/A"
		self.notesImageView?.isHidden = user.notes != nil ? false : true
		if let url = URL(string:user.avatarUrl ?? ""){
			self.userImageView?.load(url: url)
		  }
	}
    
}
