package com.makemonefromnews.makemoneyfromreadingnews.dailynews.newsread.earnmoney.breakingnewsdaily

import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.AdLoader
import com.google.android.gms.ads.AdRequest
import com.google.android.gms.ads.nativead.AdChoicesView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class NativeAdPlatformView(
    private val context: Context,
    private val adUnitId: String,
    private val adSlot: String,
    private val viewId: Int,
    private val binaryMessenger: BinaryMessenger
) : PlatformView {

    private val isMedium = adSlot == "detail" || adSlot == "nativeVideo"

    private val adView: NativeAdView = LayoutInflater.from(context).inflate(
        if (isMedium) R.layout.native_ad_layout_medium
        else R.layout.native_ad_layout_small,
        null
    ) as NativeAdView

    private val channel = MethodChannel(
        binaryMessenger,
        "native_ad_view_$viewId"
    )

    init {
        adView.visibility = View.GONE

        val cached = NativeAdCache.consume(adUnitId)
        if (cached != null) {
            bindAd(cached)
        } else {
            loadAd()
        }
    }

    private fun bindAd(nativeAd: NativeAd) {
        adView.headlineView = adView.findViewById(R.id.ad_headline)
        adView.bodyView = adView.findViewById(R.id.ad_body)
        adView.callToActionView = adView.findViewById(R.id.ad_cta)
        adView.iconView = adView.findViewById(R.id.ad_icon)

        val adChoicesView =
            adView.findViewById<AdChoicesView>(R.id.ad_choices_view)

        Log.d("NativeAd", "AdChoicesView = $adChoicesView")
        Log.d("NativeAd", "adChoices id = ${R.id.ad_choices_view}")

        adView.adChoicesView = adChoicesView

        (adView.headlineView as TextView).text = nativeAd.headline
        (adView.bodyView as TextView).text = nativeAd.body
        (adView.callToActionView as Button).text = nativeAd.callToAction
        nativeAd.icon?.drawable?.let {
            (adView.iconView as ImageView).setImageDrawable(it)
        }

//        if (isMedium) {
            val mediaView = adView.findViewById<MediaView>(R.id.ad_media)
            adView.mediaView = mediaView
//        }

        adView.setNativeAd(nativeAd)
        adView.visibility = View.VISIBLE
        channel.invokeMethod("onAdLoaded", null)
    }

    private fun loadAd() {
        AdLoader.Builder(context, adUnitId)
            .forNativeAd { nativeAd -> bindAd(nativeAd) }
            .withAdListener(object : com.google.android.gms.ads.AdListener() {
                override fun onAdFailedToLoad(error: com.google.android.gms.ads.LoadAdError) {
                    adView.visibility = View.GONE
                    channel.invokeMethod("onAdFailed", error.message)
                }
            })
            .build()
            .loadAd(AdRequest.Builder().build())
    }

    override fun getView(): View = adView
    override fun dispose() {}
}
