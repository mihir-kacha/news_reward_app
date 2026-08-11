part of '../core.dart';

class NotificationHelper {
  NotificationHelper._();

  static final NotificationHelper _instance = NotificationHelper._();

  static NotificationHelper get instance => _instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// android notification setup
  AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings(
    '@drawable/ic_notification',
  );

  /// ios notification setting
  final DarwinInitializationSettings initializationSettingsDarwin = const DarwinInitializationSettings();

  static const String _installDateKey = "notification_install_date";
  static const String _campaignScheduledKey = "campaign_scheduled";

  static final List<CampaignNotification> _dailyNotification = [
    CampaignNotification(
      day: 1,
      hour: 9,
      minute: 00,
      title: "🚨 You're leaving free coins on the table 🪙",
      body: "💰 50 coins are already yours. Open now before they disappear ⏳",
      button: "Claim Now",
      id: 100,
    ),
    CampaignNotification(
      day: 1,
      hour: 20,
      minute: 30,
      title: "👀 This is why everyone's downloading right now",
      body: "🔥 People are earning while you're scrolling something else. Don't be last 🏃",
      button: "See Why",
      id: 101,
    ),
    CampaignNotification(
      day: 2,
      hour: 8,
      minute: 00,
      title: "😴 Your coins doubled while you slept",
      body: "📈 Tap now to see how much you're really earning 🪙",
      button: "Check Balance",
      id: 102,
    ),
    CampaignNotification(
      day: 2,
      hour: 14,
      minute: 13,
      title: "😱 You won't believe how fast this adds up",
      body: "💸 Your balance just crossed a number you need to see 👇",
      button: "View Coins",
      id: 103,
    ),
    CampaignNotification(
      day: 3,
      hour: 19,
      minute: 30,
      title: "🔥 Everyone is talking about this story",
      body: "😬 Miss it and you're the only one who doesn't know",
      button: "Read Now",
      id: 104,
    ),
    CampaignNotification(
      day: 4,
      hour: 9,
      minute: 00,
      title: "⚠️ WARNING: Your streak is about to die 💀",
      body: "⏰ One tap saves everything you've built. Don't let it end",
      button: "Save Streak",
      id: 105,
    ),
    CampaignNotification(
      day: 4,
      hour: 21,
      minute: 30,
      title: "💰 He just cashed out. You could be next 👀",
      body: "🪙 Your coins are closer to withdrawal than you think",
      button: "Withdraw",
      id: 106,
    ),
    CampaignNotification(
      day: 5,
      hour: 12,
      minute: 30,
      title: "🤫 The one thing nobody's telling you",
      body: "😳 This changes everything — and it's sitting in your feed right now",
      button: "Read Story",
      id: 107,
    ),
    CampaignNotification(
      day: 5,
      hour: 20,
      minute: 00,
      title: "🏆 You're earning more than 90% of users",
      body: "📊 Keep going and see exactly where you rank",
      button: "See Rank",
      id: 108,
    ),
    CampaignNotification(
      day: 6,
      hour: 10,
      minute: 00,
      title: "🔥 DOUBLE COINS — but only for a few hours ⏳",
      body: "🎉 This weekend only. Miss it and it's gone 🚪",
      button: "Earn 2x Now",
      id: 109,
    ),
    CampaignNotification(
      day: 6,
      hour: 18,
      minute: 00,
      title: "🚨 This just changed everything",
      body: "📰 Read it now before it's old news — and earn 🪙 while you do",
      button: "Read & Earn",
      id: 110,
    ),
    CampaignNotification(
      day: 7,
      hour: 9,
      minute: 00,
      title: "🎉 7 days. 1 huge bonus. Don't blow it now",
      body: "🏅 You're one tap away from a reward most people never reach",
      button: "Claim Bonus",
      id: 111,
    ),
    CampaignNotification(
      day: 7,
      hour: 21,
      minute: 00,
      title: "🤔 99% of people get this wrong",
      body: "❓ Are you one of them? Find out in 30 seconds ⏱️",
      button: "Find Out",
      id: 112,
    ),
    CampaignNotification(
      day: 8,
      hour: 8,
      minute: 30,
      title: "⏰ Your coins expire TODAY 🚫",
      body: "🪙 Use them now or watch them vanish 💨",
      button: "Use Coins",
      id: 113,
    ),
    CampaignNotification(
      day: 8,
      hour: 13,
      minute: 00,
      title: "🎯 This was made for you. Literally.",
      body: "✨ Picked based on you — and it's earning you coins right now 🪙",
      button: "Read Now",
      id: 114,
    ),
    CampaignNotification(
      day: 9,
      hour: 19,
      minute: 00,
      title: "🎯 You just unlocked something big",
      body: "💰 Your balance hit a number worth checking immediately 👀",
      button: "Check Now",
      id: 115,
    ),
    CampaignNotification(
      day: 10,
      hour: 9,
      minute: 00,
      title: "😢 You're missing out. Every. Single. Day.",
      body: "🔥 Come back now and claim what you've already lost 🪙",
      button: "Check Now",
      id: 116,
    ),
    CampaignNotification(
      day: 10,
      hour: 20,
      minute: 00,
      title: "🔁 This happened before. It got wild 😳",
      body: "📜 History's repeating — read it before everyone else does",
      button: "Read Now",
      id: 117,
    ),
    CampaignNotification(
      day: 11,
      hour: 12,
      minute: 00,
      title: "🔥 10 DAYS. Don't ruin it now",
      body: "💪 You've come this far. One tap keeps it alive",
      button: "Keep Streak",
      id: 118,
    ),
    CampaignNotification(
      day: 11,
      hour: 21,
      minute: 00,
      title: "💸 3,200 people just got paid",
      body: "🪙 Your coins could be next. Check your balance now 👀",
      button: "Check Balance",
      id: 119,
    ),
    CampaignNotification(
      day: 12,
      hour: 9,
      minute: 00,
      title: "🎯 This affects YOU directly",
      body: "👤 Not someone else. You. Read it now ⚡",
      button: "Read Now",
      id: 120,
    ),
    CampaignNotification(
      day: 12,
      hour: 18,
      minute: 30,
      title: "🎡 Free spin. Free coins. Zero catch.",
      body: "✅ One tap. That's literally all it takes 🪙",
      button: "Spin Now",
      id: 121,
    ),
    CampaignNotification(
      day: 13,
      hour: 8,
      minute: 00,
      title: "💀 Your streak is DYING right now",
      body: "😰 12 days of work, gone in hours — unless you act ⏰",
      button: "Save It Now",
      id: 122,
    ),
    CampaignNotification(
      day: 13,
      hour: 21,
      minute: 00,
      title: "🤫 Nobody knows this yet. You will.",
      body: "🏃 Be first. Read it before it's everywhere 🌍",
      button: "Be First",
      id: 123,
    ),
    CampaignNotification(
      day: 14,
      hour: 10,
      minute: 00,
      title: "😏 You're SO close, it's almost unfair",
      body: "🪙 A few more coins and you cash out big 💰",
      button: "Almost There",
      id: 124,
    ),
    CampaignNotification(
      day: 14,
      hour: 19,
      minute: 00,
      title: "🚨 TODAY ONLY: Triple coins 🔺",
      body: "🔥 Biggest earning day of the month. Don't sleep on this 😴",
      button: "Earn 3x Now",
      id: 125,
    ),
    CampaignNotification(
      day: 15,
      hour: 9,
      minute: 00,
      title: "⏳ This is your last chance to go big",
      body: "🏁 15 days of earning comes down to today",
      button: "Go Big Now",
      id: 126,
    ),
    CampaignNotification(
      day: 15,
      hour: 21,
      minute: 00,
      title: "👀 You need to see what you missed",
      body: "📅 Your whole week, recapped — and tomorrow's surprise is already loaded 🎁",
      button: "See Recap",
      id: 127,
    ),
  ];

  Future<void> initialize() async {
    Log.success("Initialize");
    Log.debug("STEP 1: initializationSettings");
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    Log.debug("STEP 2: flutterLocalNotificationsPlugin");
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );
    Log.debug("STEP 3: flutterLocalNotificationsPlugin");
    final granted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    Log.debug("Permission: $granted");
    if (granted != true) {
      Log.debug("Permission denied");
      return;
    }
    Log.debug("STEP 4: flutterLocalNotificationsPlugin");
    await scheduleCampaignIfNeeded();
  }

  Future<void> scheduleCampaignIfNeeded() async {
    Log.success("Scheduling started");

    final prefs = await SharedPreferences.getInstance();

    final alreadyScheduled = prefs.getBool(_campaignScheduledKey) ?? false;

    if (alreadyScheduled) {
      Log.success("Campaign already scheduled");
      return;
    }

    Log.success("First launch. Scheduling campaign...");

    String? installDateString = prefs.getString(_installDateKey);

    DateTime installDate;

    if (installDateString == null) {
      installDate = DateTime.now();

      await prefs.setString(_installDateKey, installDate.toIso8601String());
    } else {
      installDate = DateTime.parse(installDateString);
    }

    final scheduled = await _scheduleCampaign(installDate);

    if (scheduled) {
      await prefs.setBool(_campaignScheduledKey, true);
    }

    Log.success("Campaign scheduled successfully");
  }

  Future<bool> _scheduleCampaign(DateTime installDate) async {
    int success = 0;

    for (final notification in _dailyNotification) {
      final scheduled = await _scheduleNotification(notification: notification, installDate: installDate);

      if (scheduled) {
        success++;
      }
    }

    Log.debug("Successfully scheduled $success notifications");

    return success > 0;
  }

  Future<bool> _scheduleNotification({
    required CampaignNotification notification,
    required DateTime installDate,
  }) async {
    DateTime scheduledTime = DateTime(
      installDate.year,
      installDate.month,
      installDate.day,
      notification.hour,
      notification.minute,
    ).add(Duration(days: notification.day - 1));

    final now = DateTime.now();

    if (!scheduledTime.isAfter(now)) {
      Log.debug("Skipping notification ${notification.id} because it's in the past.");
      return false;
    }

    try {
      final tzTime = tz.TZDateTime.from(scheduledTime, tz.local);

      Log.debug("NOW = ${DateTime.now()}");
      Log.debug("INSTALL = $installDate");
      Log.debug("ORIGINAL = $scheduledTime");
      Log.debug("TZ = ${tz.TZDateTime.from(scheduledTime, tz.local)}");
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        payload: jsonEncode({"id": notification.id, "day": notification.day}),
        scheduledDate: tzTime,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            "newspay_campaigns",
            "Campaign Notifications",
            channelDescription: "15 day notification campaign",
            importance: Importance.max,
            priority: Priority.max,
            icon: "@drawable/ic_notification",
            actions: [AndroidNotificationAction("open", notification.button)],
            // sound: const RawResourceAndroidNotificationSound("notification_sound"),
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: "notification_sound.mp3",
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
      return true;
    } catch (e, s) {
      Log.debug(e.toString());
      Log.debug(s.toString());
      return false;
    }
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    Log.debug("Notification Action : ${response.actionId}");

    Log.debug("Payload : ${response.payload}");

    /// TODO: Navigate to home screen if required.
  }

  Future<void> cancelAllScheduled() async {
    for (final notification in _dailyNotification) {
      await flutterLocalNotificationsPlugin.cancel(id: notification.id);
    }
  }

  Future<void> resetCampaign() async {
    await cancelAllScheduled();

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_installDateKey);
    await prefs.remove(_campaignScheduledKey);
  }
}

class CampaignNotification {
  final int day;
  final int hour;
  final int minute;
  final String title;
  final String body;
  final String button;
  final int id;

  CampaignNotification({
    required this.day,
    required this.hour,
    required this.minute,
    required this.title,
    required this.body,
    required this.button,
    required this.id,
  });
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse message) {
  debugPrint("onDidReceiveBackgroundNotificationResponse===> ${message.payload}");
}
