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

      if(call.method == "getInstance"){
          
      }else if(call.method == "setDefaultBannerImage"){
          
      }else if(call.method == "configureLoaderColour"){
          
      }else if(call.method == "closeWebviewOnDeeplinkEvent"){
          
      }else if(call.method == "disableGluSdk"){
          
      }else if(call.method == "isFcmApn"){
          
      }else if(call.method == "enablePrecaching"){
          
      }else if(call.method == "configureSafeArea"){

      }else if(call.method == "doRegister"){
          var userData = [String: AnyHashable]()
          userData["userId"] = "userId"
          CustomerGlu.getInstance.registerDevice(userdata: userData, loadcampaigns: false) { success, registrationModel in
              if success {
                  print("Register Successfully \(String(describing: registrationModel))")
                  
                  
              } else {
                  print("error")
              }
          }
          
      }else if(call.method == "updateProfile"){
          
      }else if(call.method == "sendEventData"){
          
      }else if(call.method == "displayCustomerGluNotification"){
          
      }else if(call.method == "getReferralId"){
          
      }else if(call.method == "openWallet"){
          CustomerGlu.getInstance.openWallet()
      }else if(call.method == "loadAllCampaigns"){
          CustomerGlu.getInstance.loadAllCampaigns()
      }else if(call.method == "loadCampaignById"){
          
      }else if(call.method == "loadCampaignsByFilter"){
          
      }


                                                                                   }

}
