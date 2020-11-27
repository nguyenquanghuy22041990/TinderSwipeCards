//
//  SceneDelegate.swift
//  TinderSwipeCards
//
//  Created by Huy Quang Nguyen on 11/20/20.
//

import UIKit
import Swinject
import SwinjectStoryboard
import RxSwift
import Moya
import Moya_ModelMapper
import Mapper

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var container: Container!
    var onlineCardsRepository: OnlineCardsRepository = OnlineCardsRepository(provider: MoyaProvider<GetPeople>(), checkNetworkManager: ReachabilityCheckNetworkManager())
    var localFavoriteCardsRepository: LocalFavoriteCardsRepository = LocalFavoriteCardsRepository(personRepository:  AnyRepository<PersonObject>())
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        injectDependencies()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    func injectDependencies() {
        container = Container()
        
        container.register(GetOnlineCardsUseCase.self) { _ in DefaultGetOnlineCardsUseCase(getCardsRepository: self.onlineCardsRepository)
        }
        
        container.register(SaveCardUseCase.self) { _ in DefaultSaveCardUseCase(localFavoriteCardsRepository: self.localFavoriteCardsRepository)
        }
        
        container.register(GetLocalFavoriteCardsUseCase.self) { _ in DefaultGetLocalFavoriteCardsUseCase(getCardsRepository: self.localFavoriteCardsRepository)
        }
        
        container.storyboardInitCompleted(ShowCardsViewController.self) { resolver, showCardsController in
            showCardsController.getCardsUseCase = resolver.resolve(GetOnlineCardsUseCase.self)
            showCardsController.saveCardUseCase = resolver.resolve(SaveCardUseCase.self)
        }
        
        container.storyboardInitCompleted(FavoriteCardsViewController.self) { resolver, favoriteCardsViewController in
            favoriteCardsViewController.getCardsUseCase = resolver.resolve(GetLocalFavoriteCardsUseCase.self)
        }
        
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        
    }

}

