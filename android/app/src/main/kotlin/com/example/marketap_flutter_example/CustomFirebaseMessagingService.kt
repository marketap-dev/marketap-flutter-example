package com.example.marketap_flutter_example


import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.marketap.sdk.client.push.MarketapFirebaseMessagingService
import android.util.Log

class CustomFirebaseMessagingService
    : FlutterFirebaseMessagingService() {   

    override fun onNewToken(token: String) {
        super.onNewToken(token)                          
    }

    override fun onMessageReceived(msg: RemoteMessage) {
        if (MarketapFirebaseMessagingService.handleMarketapRemoteMessage(this, msg)) return
        Log.d("Test App", "Message Received! (Non-Marketap Message): ${msg}")
        super.onMessageReceived(msg)           
    }
}