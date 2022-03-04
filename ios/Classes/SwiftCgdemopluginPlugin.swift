import Flutter
import UIKit
import CustomerGlu

public class SwiftCgdemopluginPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "cgdemoplugin", binaryMessenger: registrar.messenger())
        let instance = SwiftCgdemopluginPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        if(call.method == "getInstance"){
            
        } else if(call.method == "setDefaultBannerImage"){
            CustomerGlu.getInstance.setDefaultBannerImage(bannerUrl: call.arguments as! String)
        } else if(call.method == "configureLoaderColour"){
            let color = colorWithHexString(hexString: call.arguments as! String)
            CustomerGlu.getInstance.configureLoaderColour(color: [color])
        } else if(call.method == "closeWebviewOnDeeplinkEvent"){
            CustomerGlu.getInstance.closeWebviewOnDeeplinkEvent(close: call.arguments as! Bool)
        } else if(call.method == "disableGluSdk"){
            CustomerGlu.getInstance.disableGluSdk(disable: call.arguments as! Bool)
        } else if(call.method == "isFcmApn"){
            CustomerGlu.getInstance.isFcmApn(fcmApn: call.arguments as! String)
        }else if(call.method == "setApnFcmToken"){
           
            let arguments = call.arguments as! Dictionary<String, Any>
            let apntoken = arguments["apntoken"] as? String
            let fcmtoken = arguments["fcmtoken"] as? String
            
            CustomerGlu.getInstance.fcmToken = fcmtoken ?? ""
            CustomerGlu.getInstance.apnToken = apntoken ?? ""
            
       }else if(call.method == "enablePrecaching"){
        
        } else if(call.method == "configureSafeArea"){
            let arguments = call.arguments as! Dictionary<String, Any>
            let topColor = colorWithHexString(hexString: arguments["topSafeAreaColor"] as! String)
            let bottomColor = colorWithHexString(hexString: arguments["bottomSafeAreaColor"] as! String)
            CustomerGlu.getInstance.configureSafeArea(topHeight: arguments["topHeight"] as! Int, bottomHeight: arguments["bottomHeight"] as! Int, topSafeAreaColor: topColor, bottomSafeAreaColor: bottomColor)
        } else if(call.method == "doRegister"){
            let arguments = call.arguments as! Dictionary<String, Any>
            let userData = arguments["profile"] as! Dictionary<String, AnyHashable>
            CustomerGlu.getInstance.registerDevice(userdata: userData, loadcampaigns: arguments["loadCampaigns"] as! Bool) { success, registrationModel in
                if success {
                    print("Register Successfully \(String(describing: registrationModel))")
                    result("true")
                } else {
                    result("false")
                    print("error")
                }
            }
        } else if(call.method == "updateProfile"){
            let arguments = call.arguments as! Dictionary<String, Any>
            let userData = arguments["profile"] as! Dictionary<String, AnyHashable>
            CustomerGlu.getInstance.updateProfile(userdata: userData) { success, registrationModel in
                if success {
                    print("Register Successfully \(String(describing: registrationModel))")
                } else {
                    print("error")
                }
            }
        } else if(call.method == "sendEventData"){
            let arguments = call.arguments as! Dictionary<String, Any>
            let eventData = arguments["eventData"] as! Dictionary<String, Any>
            CustomerGlu.getInstance.sendEventData(eventName: arguments["eventName"] as! String, eventProperties: eventData)
        } else if(call.method == "displayCustomerGluNotification"){
            let arguments = call.arguments as! Dictionary<String, Any>
            let message = arguments["message"] as! Dictionary<String, AnyHashable>
            CustomerGlu.getInstance.cgapplication(UIApplication.shared, didReceiveRemoteNotification: message, backgroundAlpha: 0.5, fetchCompletionHandler: {_ in })
        }else if(call.method == "displayBackgroundNotification"){
            let arguments = call.arguments as! Dictionary<String, Any>
            let message = arguments["message"] as! Dictionary<String, AnyHashable>
            CustomerGlu.getInstance.displayBackgroundNotification(remoteMessage: message as? [String: AnyHashable] ?? ["glu_message_type": "glu"])
        } else if(call.method == "getReferralId"){
            let url = URL(string: call.arguments as! String)
            if url == nil {
                return
            }
            let referId = CustomerGlu.getInstance.getReferralId(deepLink: url!)
            result(referId)
        } else if(call.method == "openWallet"){
            CustomerGlu.getInstance.openWallet()
        } else if(call.method == "loadAllCampaigns"){
            CustomerGlu.getInstance.loadAllCampaigns()
        } else if(call.method == "loadCampaignById"){
            CustomerGlu.getInstance.loadCampaignById(campaign_id: call.arguments as! String)
        } else if(call.method == "loadCampaignsByFilter") {
            let arguments = call.arguments as! Dictionary<String, Any>
            let dict = arguments["filters"] as! Dictionary<String, Any>
            CustomerGlu.getInstance.loadCampaignByFilter(parameters: dict as NSDictionary)
        } else if(call.method == "enableAnalyticsEvent") {
            CustomerGlu.getInstance.enableAnalyticsEvent(event: call.arguments as! Bool)
        } else if(call.method == "clearGluData") {
            CustomerGlu.getInstance.clearGluData()
        } else if(call.method == "loadCampaignsByType") {
            CustomerGlu.getInstance.loadCampaignsByType(type: call.arguments as! String)
        } else if(call.method == "loadCampaignByStatus") {
            CustomerGlu.getInstance.loadCampaignByStatus(status: call.arguments as! String)
        }
        else{
            print(call.method+" Not Implemented")
        }
    }
    
    private func colorWithHexString(hexString: String) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    
    private func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
