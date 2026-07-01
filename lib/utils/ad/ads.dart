import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/data/preference/preference.dart';
import 'package:inshorts/utils/enum.dart';
import 'package:network/helper/logger.dart';
import 'package:network/network.dart';
import 'package:gma_mediation_unity/gma_mediation_unity.dart';

part 'ad_helper.dart';
part 'interstitial_ads_loader.dart';
part 'base_ad_loader.dart';
part 'ad_states.dart';
part 'ads_config.dart';
part 'rewarded_interstitial_ads_loader.dart';
part 'reward_ads_loader.dart';
part 'banner_ads_loader.dart';
part 'app_open_ads_loader.dart';
part 'native_ad_loader.dart';

typedef OnAdLoaded = void Function(String userId);
typedef OnAdFailed = void Function(String error);
typedef OnAdDismissed = void Function();
typedef OnAdShown = void Function();

typedef OnRewardEarned = void Function(AdReward rewards);

typedef OnNativeAdLoaded = void Function(NativeAd as, String userId);
