part of '../core.dart';


extension Ext on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  EdgeInsets get padding => MediaQuery.of(this).padding;

  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  NavigatorState get navigator => Navigator.of(this);

  dynamic get args => ModalRoute.of(this)?.settings.arguments;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
