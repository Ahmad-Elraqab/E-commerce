import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Initialize Google Maps with API key from Info.plist
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
       let plist = NSDictionary(contentsOfFile: path),
       let apiKey = plist["GMSApiKey"] as? String {
      GMSServices.provideAPIKey(apiKey)
    } else {
      // Fallback: Replace "YOUR_API_KEY_HERE" with your actual Google Maps API key
      // You can get an API key from: https://console.cloud.google.com/google/maps-apis
      GMSServices.provideAPIKey("AIzaSyCWPhvse6kGhMYgnBKI7PbogJwcGkhBktg")
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
