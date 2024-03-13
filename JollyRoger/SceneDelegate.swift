//
//  SceneDelegate.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else {
            return
        }
        
        let coreDataService = (UIApplication.shared.delegate as? AppDelegate)?.coreDataService
        let opportunitiesService = JROpportunitiesService(coreDataService: coreDataService)
        let viewController = JROpportunitiesListVC(opportunitiesService: opportunitiesService)
        let navvc = UINavigationController(rootViewController: viewController)
        
        window = UIWindow(frame: windowsScene.coordinateSpace.bounds)
        window?.backgroundColor = .white
        window?.windowScene = windowsScene
        window?.rootViewController = navvc
        window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.coreDataService.saveRootContext()
    }


}

