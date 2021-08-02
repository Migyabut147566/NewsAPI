//
//  Tabs.swift
//  NewsAPI
//
//  Created by Migy Yabut on 7/30/21.
//

import UIKit

enum Tabs: String, CaseIterable {
    case UnitedStates = "UnitedStates"
    case Canada = "Canada"
    
    var viewController: UIViewController {
        switch self {
        case .UnitedStates:
            return UnitedStatesViewController()
        case .Canada:
            return CanadaViewController()
        }
    }
    var icon: UIImage? {
        switch self {
        case .UnitedStates:
            return UIImage(systemName: "flag.fill")
        case .Canada:
            return UIImage(systemName: "flag")
        }
    }
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
