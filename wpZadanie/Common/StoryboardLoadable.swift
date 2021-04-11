//
//  StoryboardExtension.swift
//  wpZadanie
//
//  Created by Filip Harasim on 29/02/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

protocol StoryboardLoadable: AnyObject {
    static var storyboardName: String { get }
    static var storyboardControllerId: String { get }
}

extension StoryboardLoadable where Self: UIViewController {
    static var storyboardName: String {
        return String(describing: Self.self)
    }

    static var storyboardControllerId: String {
        return String(describing: Self.self)
    }

    static func instantiate() -> Self? {
        let bundle = Bundle(for: Self.self)
        let storyboard = UIStoryboard(name: Self.storyboardName, bundle: bundle)

        return storyboard.instantiateViewController(withIdentifier: Self.storyboardControllerId) as? Self
    }
}
