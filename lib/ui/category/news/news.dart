import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inshorts/components/news_cell.dart';
import 'package:inshorts/components/news_pay_appbar.dart';
import 'package:inshorts/components/loading_indicator.dart';
import 'package:inshorts/components/paginated_listener.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:inshorts/utils/enum.dart';
import 'package:network/helper/pagination_helper/pagination_helper.dart';
import 'package:network/network.dart';
import 'package:provider/provider.dart';

part 'news_screen.dart';
part 'news_provider.dart';