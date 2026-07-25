import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inshorts/components/alert_message.dart';
import 'package:inshorts/components/loading_indicator.dart';
import 'package:inshorts/components/network_dialog.dart';
import 'package:inshorts/data/preference/preference.dart';
import 'package:inshorts/firebase_options.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:inshorts/routes/routes.dart';
import 'package:inshorts/utils/ad/ads.dart';
import 'package:intl/intl.dart';
import 'package:network/helper/logger.dart';
import 'package:network/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

part 'base/base_provider.dart';

part 'extension/build_context_ext.dart';

part 'extension/color_ext.dart';

part 'extension/double_ext.dart';

part 'extension/int_ext.dart';

part 'extension/string_extension.dart';

part 'helper/alerts_helper.dart';

part 'helper/loading_handler.dart';

part 'helper/subscription_helper.dart';

part 'extension/list_ext.dart';

part 'helper/firebase_helper.dart';

part 'extension/currency_ext.dart';

part 'helper/connectivity_helper.dart';
part 'helper/navigation_ad_helper.dart';
part 'helper/notification_helper.dart';
part 'helper/lifecycle_handler.dart';