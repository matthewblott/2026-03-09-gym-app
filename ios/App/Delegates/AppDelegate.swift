import BridgeComponents
import HotwireNative
import UIKit
import WebKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
#if DEBUG
    Hotwire.config.debugLoggingEnabled = true
#endif
    Hotwire.registerBridgeComponents([
//      SessionComponent.self,
      BridgeComponents.ButtonComponent.self,
//      BackComponent.self,
    ])
    let localPathConfigURL = Bundle.main.url(forResource: "path-configuration", withExtension: "json")!

    Hotwire.loadPathConfiguration(from: [
      .file(localPathConfigURL),
    ])
    Hotwire.config.defaultViewController = { ViewController(url: $0) }
    Hotwire.config.applicationUserAgentPrefix = "Hotwire Native;"
    return true
  }
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
}
