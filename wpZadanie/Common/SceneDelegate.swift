//
//  SceneDelegate.swift
//  wpZadanie
//
//  Created by Filip Harasim on 29/02/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            guard let vc = QuizListViewController.instantiate() else {
                fatalError()
            }
            let nc = NetworkClient()
            let dataProvider = DataProvider(client: nc)
            vc.viewModel = QuizListViewModel(dataProvider: dataProvider)
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = UINavigationController(rootViewController: vc)
            window?.makeKeyAndVisible()
        }
    }

}

