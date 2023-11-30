//
//  SceneDelegate.swift
//  BMIApp
//
//  Created by 예찬 on 11/23/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let viewController = ViewController()
        let navigationViewController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

