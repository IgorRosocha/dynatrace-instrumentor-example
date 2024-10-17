import SwiftUI
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Internal properties
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIHostingController(
            rootView: ContentView()
            )
        window?.makeKeyAndVisible()
        
        return true
    }
}
