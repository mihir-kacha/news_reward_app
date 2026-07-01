package com.makemonefromnews.makemoneyfromreadingnews.dailynews.newsread.earnmoney.breakingnewsdaily

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.platformViewsController.registry
            .registerViewFactory(
                "custom_native_ad_view",
                NativeAdViewFactory(this, flutterEngine.dartExecutor.binaryMessenger)
            )

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "native_ad_preload")
            .setMethodCallHandler { call, result ->
                if (call.method == "preload") {
                    val adUnitId = call.argument<String>("adUnitId") ?: return@setMethodCallHandler
                    val adSlot = call.argument<String>("adSlot") ?: "feed"
                    NativeAdCache.preload(this, adUnitId, adSlot)
                    result.success(null)
                }
            }
    }
}

