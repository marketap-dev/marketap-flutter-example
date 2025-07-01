//
//  NotificationService.swift
//  NotificationServiceExtension
//
//  Created by 이동현 on 6/19/25.
//

import UserNotifications
import MarketapSDKNotificationServiceExtension

class NotificationService: UNNotificationServiceExtension {
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        _ = MarketapNotificationService.didReceive(request, withContentHandler: contentHandler)
    }
    
    override func serviceExtensionTimeWillExpire() {
        _ = MarketapNotificationService.serviceExtensionTimeWillExpire()
    }

}
