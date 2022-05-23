//
//  SceneDelegate.swift
//  Journey
//
//  Created by 초이 on 2021/06/28.
//

import UIKit
import KakaoSDKAuth

import Siren

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
           if let url = URLContexts.first?.url {
               if (AuthApi.isKakaoTalkLoginUrl(url)) {
                   _ = AuthController.handleOpenUrl(url: url)
               }
           }
       }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let siren = Siren.shared
        siren.presentationManager = PresentationManager(
          appName: "Mohaeng",
          alertTitle: "업데이트 안하고 모행?",
          alertMessage: "모행을 아프게 했던 버그가 수정됐어. \n반드시 업데이트를 해야만 하니까 아래 버튼을 꼭 눌러줘!",
          updateButtonTitle: "업데이트 하러가기",
          forceLanguageLocalization: .korean
        )
        siren.rulesManager = RulesManager(globalRules: .critical)
        siren.apiManager = APIManager(country: .korea) // 기준 위치 대한민국 앱스토어로 변경
        siren.wail(performCheck: .onDemand) { _ in }
                
        if !hasJwtToken() {
            setRootViewControllerToOnBoarding()
        } else {
            print(UserDefaults.standard.string(forKey: "jwtToken"))
            setRootViewControllerToTabbar()
        }
        self.window?.backgroundColor = .white
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    private func hasJwtToken() -> Bool {
        return UserDefaults.standard.object(forKey: "jwtToken") != nil
    }
    
    private func setRootViewControllerToOnBoarding() {
        self.navigationController = UINavigationController(rootViewController: OnBoarding1ViewController())
        self.window?.rootViewController = self.navigationController
    }
    
    private func setRootViewControllerToLogin() {
        let loginStoryboard = UIStoryboard(name: Const.Storyboard.Name.login, bundle: nil)
        let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.login)
        self.navigationController = UINavigationController(rootViewController: loginViewController)
        self.window?.rootViewController = self.navigationController
    }
    
    private func setRootViewControllerToTabbar() {
        let tabbarStoryboard = UIStoryboard(name: Const.Storyboard.Name.tabbar, bundle: nil)
        guard let tabbarViewController = tabbarStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.tabbar) as? TabbarViewController else {
            return
        }
        tabbarViewController.modalPresentationStyle = .fullScreen
        tabbarViewController.modalTransitionStyle = .crossDissolve
        self.window?.rootViewController = tabbarViewController
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
    }


}

