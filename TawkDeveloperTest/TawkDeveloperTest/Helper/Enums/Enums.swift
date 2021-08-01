//
//  Enums.swift
//  TawkDeveloperTest
//
//  Created by Shairjeel Ahmed on 30/07/2021.
//

import Foundation
import UIKit

enum AppStoryboard : String {
	case Main
	
	var instance : UIStoryboard {
		return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
	}
	
	func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
		
		let storyboardID = (viewControllerClass as UIViewController.Type).storyboardId
		
		guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
			fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile: \(file) \nLine Number: \(line) \nFunction: \(function)")
		}
		
		return scene
	}
	
	func initialViewController() -> UIViewController? {
		return instance.instantiateInitialViewController()
	}
}
