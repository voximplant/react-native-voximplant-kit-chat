import UIKit
import React
import React_RCTAppDelegate
import ReactAppDependencyProvider
import react_native_voximplant_kit_chat

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  var reactNativeDelegate: ReactNativeDelegate?
  var reactNativeFactory: RCTReactNativeFactory?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    let delegate = ReactNativeDelegate()
    let factory = RCTReactNativeFactory(delegate: delegate)
    delegate.dependencyProvider = RCTAppDependencyProvider()

    reactNativeDelegate = delegate
    reactNativeFactory = factory

    window = UIWindow(frame: UIScreen.main.bounds)

    let rootView = factory.rootViewFactory.view(withModuleName: "VoximplantKitChatExample",
                                                initialProperties: nil,
                                                launchOptions: launchOptions)
    let rootViewController = delegate.createRootViewController()
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.setNavigationBarHidden(true, animated: false)
    delegate.setRootView(rootView, toRootViewController: rootViewController)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()

    RNVIKitChatImpl.rootViewController = rootViewController

    return true
  }
}

class ReactNativeDelegate: RCTDefaultReactNativeFactoryDelegate {
  override func sourceURL(for bridge: RCTBridge) -> URL? {
    self.bundleURL()
  }

  override func bundleURL() -> URL? {
#if DEBUG
    RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
#else
    Bundle.main.url(forResource: "main", withExtension: "jsbundle")
#endif
  }
}
