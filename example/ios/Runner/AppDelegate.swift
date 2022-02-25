import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let channelName = "wingquest.stablekernel.io/speech"
    var methodChannel = FlutterMethodChannel()
    
   // let channelName = "wingquest.stablekernel.io/speech"
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.catchDeeplinkNotification),
                  name: Notification.Name("CUSTOMERGLU_DEEPLINK_EVENT"),
                  object: nil)
      NotificationCenter.default.addObserver(
                self,
                selector: #selector(self.catchAnalyticsNotification),
                name: Notification.Name("CUSTOMERGLU_ANALYTICS_EVENT"),
                object: nil)
      
    let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
    methodChannel = FlutterMethodChannel(name: channelName,
                           binaryMessenger: rootViewController as! FlutterBinaryMessenger)
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    @objc private func catchAnalyticsNotification(notification: NSNotification) {
          if let userInfo = notification.userInfo as? [String: Any]
          {
             print(userInfo)
             methodChannel.invokeMethod("CUSTOMERGLU_ANALYTICS_EVENT", arguments: "")
        }
    }
    
    @objc private func catchDeeplinkNotification(notification: NSNotification) {
            //do stuff using the userInfo property of the notification object
        if let userInfo = notification.userInfo as? [String: Any]
        {
           print(userInfo)
            methodChannel.invokeMethod("CUSTOMERGLU_DEEPLINK_EVENT", arguments: "")
      }
        }
}
