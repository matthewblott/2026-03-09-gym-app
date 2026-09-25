import HotwireNative
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  private let navigator = Navigator(configuration: .init(
    name: "main",
    startLocation: Endpoint.baseURL!
  ))
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    window = UIWindow(windowScene: windowScene)
    navigator.delegate = self
    window?.rootViewController = navigator.rootViewController
    window?.makeKeyAndVisible()
    navigator.start()
  }
}

extension SceneDelegate: NavigatorDelegate {
  func handle(proposal: VisitProposal) -> ProposalResult {
    return .accept
  }
}
