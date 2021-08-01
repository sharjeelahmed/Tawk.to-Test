//
//  UIViewControllerExtension.swift
//  TawkDeveloperTest
//
//  Created by Shairjeel Ahmed on 30/07/2021.
//

import Foundation
import UIKit

extension UIViewController {
	class var storyboardId : String {
		return "\(self)"
	}
	
	static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
		return appStoryboard.viewController(viewControllerClass: self)
	}
	
	var className: String {
		return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!;
	}
}

extension UIViewController {
	func hideKeyboardWhenTappedAround() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}

extension UIViewController {
	func dispLayError(){
		let alertController = UIAlertController(title:"Alert",message:"No internet connection",preferredStyle:.alert)
		self.present(alertController,animated:true,completion:{Timer.scheduledTimer(withTimeInterval: 3, repeats:false, block: {_ in
			self.dismiss(animated: true, completion: nil)
		})})
	}
}



