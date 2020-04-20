import UIKit
import Flutter
import RealmSwift

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    
    let config = Realm.Configuration(
        schemaVersion: 1,
        
        // Set the block which will be called automatically when opening a Realm with
        // a schema version lower than the one set above
        migrationBlock: { migration, oldSchemaVersion in
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            if (oldSchemaVersion < 1) {
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
            }
    })
    
    // Tell Realm to use this new configuration object for the default Realm
    Realm.Configuration.defaultConfiguration = config
    
    let platformMethods = PlatformMethods()
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let customChannel = FlutterMethodChannel(name: "products.ishop.app",
                                    binaryMessenger: controller.binaryMessenger)
    customChannel.setMethodCallHandler({
       (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      switch call.method {
        case "listProduct":
          platformMethods.listProduct(call: call, result: result)
        case "listCat":
          platformMethods.listCat(call: call, result: result)
      case "deleteCat":
        platformMethods.deleteCat(call: call, result: result)
        default:
          result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

