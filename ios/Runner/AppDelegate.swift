import UIKit
import Flutter
import NetworkExtension

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

    let methodChannel = FlutterMethodChannel(name: "WiFiLink_iOS", binaryMessenger: controller.binaryMessenger)

    methodChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "connectWiFi" {
        guard let args = call.arguments as? [String: Any],
              let ssid = args["ssid"] as? String,
              let password = args["password"] as? String else {
            result(false)
            return
        }
        let manager = NEHotspotConfigurationManager.shared
        let isWEP = false
        let ssidA = "Buffalo-G-B6B0"
        let passwordA = "ficcyhm7gn7nn"
        if ssid == ssidA {
            print("SSID: is same")
        }
        if password == passwordA {
            print("SSID: password is same")
        }
        print("SSID: |\(ssid)|, Password: |\(password)|")
        let hotspotConfiguration = NEHotspotConfiguration(
            ssid: ssid.trimmingCharacters(in: .whitespaces),
            passphrase: password.trimmingCharacters(in: .whitespaces),
            isWEP: isWEP)
        hotspotConfiguration.joinOnce = false
        hotspotConfiguration.lifeTimeInDays = 1

        manager.apply(hotspotConfiguration) { (error) in
            if let error = error {
                print(error.localizedDescription)
                result(false)
            } else {
                result(true)
            }
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
