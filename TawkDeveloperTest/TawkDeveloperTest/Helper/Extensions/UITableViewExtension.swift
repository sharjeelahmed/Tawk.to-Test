//
//  UITableViewExtension.swift
//  Ekuep-MP-Seller
//
//  Created by Shairjeel Ahmed on 13/07/2021.
//  Copyright © 2021 Shairjeel Ahmed. All rights reserved.
//

import Foundation
import UIKit
extension UITableViewCell {
	static var identifier: String {
		return "\(self)"
	}
}

extension UITableView {
	func returnIndexPath(cell: UITableViewCell) -> IndexPath?{
		guard let indexPath = self.indexPath(for: cell) else {
			return nil
		}
		return indexPath
	}
}

extension UICollectionViewCell {
	static var identifier: String {
		return "\(self)"
	}
}

extension UIViewController {
	static var identifier: String {
		return "\(self)"
	}
}

extension UITableView {

func indicatorView() -> UIActivityIndicatorView{
	var activityIndicatorView = UIActivityIndicatorView()
	if self.tableFooterView == nil {
		let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 80)
		activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
		activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
		
		if #available(iOS 13.0, *) {
			activityIndicatorView.style = .large
		} else {
			// Fallback on earlier versions
			activityIndicatorView.style = .whiteLarge
		}
		
		activityIndicatorView.color = UIColor.gray
		activityIndicatorView.hidesWhenStopped = true

		self.tableFooterView = activityIndicatorView
		return activityIndicatorView
	}
	else {
		return activityIndicatorView
	}
}

func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
	
	indicatorView().startAnimating()
	if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
		if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				closure()
			}
		}
	}
}

func stopLoading() {
	if self.tableFooterView != nil {
		self.indicatorView().stopAnimating()
		self.tableFooterView = nil
	}
	else {
		self.tableFooterView = nil
	}
}
}



