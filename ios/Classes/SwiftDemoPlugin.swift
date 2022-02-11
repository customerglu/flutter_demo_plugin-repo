import Flutter
import UIKit
import CustomerGlu

public class SwiftDemoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "demo_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftDemoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

  
    
       var userData = [String: AnyHashable]()
        userData["userId"] = "userId"
       CustomerGlu.getInstance.registerDevice(userdata: userData, loadcampaigns: false) { success, registrationModel in
            if success {
               print("Register Successfully \(String(describing: registrationModel))")
                CustomerGlu.getInstance.openWallet()

            } else {
                print("error")
            }
        }
  }

}
