import Flutter
import UIKit
import MarketapSDK

@main
@objc
class AppDelegate: FlutterAppDelegate {

    private let channelName = "marketap/deeplink"
    private var channel: FlutterMethodChannel?

    // MARK: - App launch ------------------------------------------------------

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        GeneratedPluginRegistrant.register(with: self)

        // UNUserNotificationCenter delegate
        UNUserNotificationCenter.current().delegate = self

        // Marketap 초기화
        Marketap.application(application, didFinishLaunchingWithOptions: launchOptions)

        // Flutter-Native 채널
        if let controller = window?.rootViewController as? FlutterViewController {
            channel = FlutterMethodChannel(
                name: channelName,
                binaryMessenger: controller.binaryMessenger
            )
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // MARK: - Push token ------------------------------------------------------

    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Marketap.setPushToken(token: deviceToken)
        super.application(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
        )
    }

    // MARK: - Notification presentation --------------------------------------

    override func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        if Marketap.userNotificationCenter(
            center,
            willPresent: notification,
            withCompletionHandler: completionHandler
        ) { return }

        super.userNotificationCenter(
            center,
            willPresent: notification,
            withCompletionHandler: completionHandler
        )
    }

    // MARK: - Notification click ---------------------------------------------

    override func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        if Marketap.userNotificationCenter(
            center,
            didReceive: response,
            withCompletionHandler: completionHandler
        ) { return }

        super.userNotificationCenter(
            center,
            didReceive: response,
            withCompletionHandler: completionHandler
        )
    }

    // MARK: - Deep link -------------------------------------------------------

    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        channel?.invokeMethod("onLink", arguments: url.absoluteString)
        return true
    }
}
