package com.makemonefromnews.makemoneyfromreadingnews.dailynews.newsread.earnmoney.breakingnewsdaily

import android.content.Context
import com.google.android.gms.ads.AdLoader
import com.google.android.gms.ads.AdRequest
import com.google.android.gms.ads.nativead.NativeAd

object NativeAdCache {
    private val cache = mutableMapOf<String, NativeAd?>()
    private val loading = mutableSetOf<String>()

    fun preload(context: Context, adUnitId: String, adSlot: String) {
        if (cache.containsKey(adUnitId) || loading.contains(adUnitId)) return

        loading.add(adUnitId)
        AdLoader.Builder(context, adUnitId)
            .forNativeAd { nativeAd ->
                cache[adUnitId] = nativeAd
                loading.remove(adUnitId)
            }
            .withAdListener(object : com.google.android.gms.ads.AdListener() {
                override fun onAdFailedToLoad(error: com.google.android.gms.ads.LoadAdError) {
                    cache[adUnitId] = null
                    loading.remove(adUnitId)
                }
            })
            .build()
            .loadAd(AdRequest.Builder().build())
    }

    fun consume(adUnitId: String): NativeAd? {
        val ad = cache[adUnitId]
        cache.remove(adUnitId)
        return ad
    }

    fun has(adUnitId: String): Boolean = cache.containsKey(adUnitId)
}
