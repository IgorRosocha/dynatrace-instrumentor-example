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
        
        Dynatrace.handoverInstrumentorConfig([kDTXSwiftMappingJson: "_DYNATRACE_SWIFTUI_MAPPING_PLACEHOLDER_"])
        
        return true
    }
}
