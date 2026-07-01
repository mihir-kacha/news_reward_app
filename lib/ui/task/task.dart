import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/components/news_pay_appbar.dart';
import 'package:inshorts/components/news_pay_coin_card.dart';
import 'package:inshorts/components/common_task_card.dart';
import 'package:inshorts/components/dynamic_grid_view.dart';
import 'package:inshorts/components/reward_ad_failed_dialog.dart';
import 'package:inshorts/components/reward_ad_watch_dialog.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/data/preference/preference.dart';
import 'package:inshorts/generated/assets.gen.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:inshorts/utils/ad/ads.dart';
import 'package:inshorts/utils/common_button.dart';
import 'package:inshorts/utils/common_functions.dart';
import 'package:inshorts/utils/enum.dart';
import 'package:network/helper/logger.dart';
import 'package:network/network.dart';
import 'package:provider/provider.dart';

part 'task_screen.dart';
part 'task_provider.dart';
part 'components/task_card.dart';
part 'components/reading_news_task.dart';