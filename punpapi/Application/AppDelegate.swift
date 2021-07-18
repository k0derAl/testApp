import UIKit
import AlamofireNetworkActivityLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        DI.initDependencies(self)
        DI.initNetworkDependencies(self)
        
        let vc = ListVC()
        if let window = window {
            let navigation = UINavigationController(rootViewController: vc)
            
            if #available(iOS 13.0, *) {
                window.overrideUserInterfaceStyle = .light
            }
            window.rootViewController = navigation
            window.makeKeyAndVisible()
        }
        return true
    }
    
}

