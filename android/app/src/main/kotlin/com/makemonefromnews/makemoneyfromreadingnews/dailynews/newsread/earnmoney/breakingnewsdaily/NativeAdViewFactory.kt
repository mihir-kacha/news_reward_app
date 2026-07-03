package com.makemonefromnews.makemoneyfromreadingnews.dailynews.newsread.earnmoney.breakingnewsdaily

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeAdViewFactory(
    private val context: Context,
    private val binaryMessenger: BinaryMessenger
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as Map<String, Any>
        return NativeAdPlatformView(
            context,
            params["adUnitId"] as String,
            params["adSlot"] as? String ?: "feed",
            params["detailLayout"] as? String ?: "buttonBottom",
            viewId,
            binaryMessenger
        )
    }
}
