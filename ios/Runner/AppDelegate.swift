import UIKit
import Flutter
import AvFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  var player: AVAudioPlayer?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    FlutterMethodChannel(name: "marconi_audio_stream", binaryMessenger: controller.binaryMessenger)
    .setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "play" {
        let url_: String = call.arguments["someInfo1"]
        self?.play(url: url_)
        result(nil)
      } else if call.method == "pause" {
        self?.stop()
        result(nil)
      } else if call.method == "stop" {
        self?.stop()
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
        return
      }
    })


    private func play(url: String) throws -> String {
      // do {
        var audioUrl: URL = URL(string: url)
        player = try AVAudioPlayer(contentsOf: audioUrl)
        player?.play()
      // } catch e {
      //   throw e
      // }
    }

    private func stop(url: String) throws -> String {
      // do {
        player?.stop()
      // } catch e {
      //   throw e
      // }
    }


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
