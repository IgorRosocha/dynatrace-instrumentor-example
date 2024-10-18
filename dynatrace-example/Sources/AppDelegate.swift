import SwiftUI
import UIKit
import Dynatrace

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
        
        Dynatrace.handoverInstrumentorConfig([kDTXSwiftMappingJson: "{\"generationTime\":\"2024-10-18 12:11:33\",\"instrumentorVersion\":\"8.299.1.1005\",\"mappings\":{\"dynatrace_example\"
:{}},\"schemaVersion\":1}"])
        
        return true
    }
}
