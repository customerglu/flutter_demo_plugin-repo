import UIKit
import Flutter
import Firebase
import CustomerGlu

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    let channelName = "CUSTOMERGLU_EVENTS"
    var methodChannel = FlutterMethodChannel()
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
      

    if #available(iOS 10.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
    } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
    }

    application.registerForRemoteNotifications()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Change this to your preferred presentation option
        CustomerGlu.getInstance.cgUserNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    }
    
    @objc private func catchAnalyticsNotification(notification: NSNotification) {
          if let userInfo = notification.userInfo as? [String: Any]
          {
             print(userInfo)
             methodChannel.invokeMethod("CUSTOMERGLU_ANALYTICS_EVENT", arguments: userInfo)
        }
    }
    
    @objc private func catchDeeplinkNotification(notification: NSNotification) {
            //do stuff using the userInfo property of the notification object
        if let userInfo = notification.userInfo as? [String: Any]
        {
           print(userInfo)
            methodChannel.invokeMethod("CUSTOMERGLU_DEEPLINK_EVENT", arguments: userInfo)
      }
        }
    
    
}
