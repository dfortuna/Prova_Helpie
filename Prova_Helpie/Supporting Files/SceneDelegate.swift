//
//  SceneDelegate.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 27/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let mainViewController = ContactsListTableViewController()
        
        // TODO: Call Login screen flow here and retrive real logged user data.
        mainViewController.loggedUser =  User(name: "Denis Fortuna",
                                              phoneNumber: "9999-1234",
                                              photoUrl: "https://firebasestorage.googleapis.com/v0",
//                                              photoUrl:  "https://firebasestorage.googleapis.com/v0/b/prova-helpie.appspot.com/o/Users%2F565AFF28-B476-4039-96A2-C30A200E39D1.png?alt=media&token=ea1f8efc-222e-4e19-bf14-53b4e1ad31c0",
                                              comments: "battery about to dye!",
                                              email: "denis.fortuna@gmail.com")
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [mainViewController]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

