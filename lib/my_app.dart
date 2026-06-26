import 'package:flutter/material.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:inshorts/routes/routes.dart';
import 'package:inshorts/utils/common_functions.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRoutes appRoute = AppRoutes();
    return GestureDetector(
      onTap: CommonFunc.closeKeyboard,
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
            child: Builder(
              builder: (context) {
                return child!;
              },
            ),
          );
        },
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: lightTheme,
        initialRoute: appRoute.initRoute,
        onGenerateRoute: (settings) => appRoute.onGeneratedRoute(settings),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
