part of 'resources.dart';

ThemeData get lightTheme => _getThemeData(_lightThemeColors);

ThemeData _getThemeData(ColorScheme colorScheme) => ThemeData(
  colorScheme: colorScheme,
  useMaterial3: true,
  fontFamily: FontFamily.plusJakartaSans,
  brightness: colorScheme.brightness,
  primaryColor: colorScheme.primary,
  canvasColor: colorScheme.surface,
  scaffoldBackgroundColor: colorScheme.surface,
  hoverColor: colorScheme.surface,
  visualDensity: VisualDensity.standard,
  extensions: {appColor},
  textTheme: _textTheme(colorScheme),
  snackBarTheme: _snackBarThemeData(colorScheme),
  dialogTheme: _dialogTheme(colorScheme),
  bottomSheetTheme: _bottomSheetThemeData(colorScheme),
  datePickerTheme: _datePickerThemeData(colorScheme),
  timePickerTheme: _timePickerThemeData(colorScheme),
  scrollbarTheme: _scrollbarThemeData(colorScheme),
  popupMenuTheme: _popupMenuThemeData(colorScheme),
  appBarTheme: _appBarTheme(colorScheme),
  bottomNavigationBarTheme: _bottomNavigationBarThemeData(colorScheme),
  elevatedButtonTheme: _elevatedButtonThemeData(colorScheme),
  filledButtonTheme: _filledButtonThemeData(colorScheme),
  textButtonTheme: _textButtonThemeData(colorScheme),
  outlinedButtonTheme: _outlinedButtonThemeData(colorScheme),
  tabBarTheme: TabBarThemeData(indicatorColor: colorScheme.primary),
  inputDecorationTheme: _inputDecorationTheme(colorScheme),
  dividerTheme: DividerThemeData(color: colorScheme.outline, endIndent: 0, indent: 0, thickness: 1),
  splashColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  checkboxTheme: CheckboxThemeData(side: BorderSide(color: colorScheme.outline)),
  radioTheme: RadioThemeData(side: BorderSide(color: colorScheme.outline, width: 2)),
);

ColorScheme get _lightThemeColors => ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF1FB255),
  // primary: Color(0xFF14532D),
  secondary: Color(0xFF45CD77),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFF5F5F5),
  error: Color(0xFFD32F2F),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFEBEE),
  onErrorContainer: Color(0xFFB71C1C),
  surface: Color(0xFFEEEEEF),
  surfaceContainerLow: Color(0xFFF8F9FA),
  surfaceContainerHigh: Color(0xFFF1F3F4),
  onSurface: Color(0xFF111827),
  onSurfaceVariant: Color(0xFF6B7280),
  tertiary: Color(0xFF374151),
  outline: Color(0xFFE5E7EB),
  outlineVariant: Color(0xFFEEEEEF),
  surfaceTint: Color(0xFF667085),
  shadow: Color(0xFF000000),
);

StatusColor get appColor => StatusColor(
  info: Color(0xFFEEA734),
  onInfo: Color(0xFF191D21),
  warning: Color(0xFFFFEACA),
  onWarning: Color(0xFF191D21),
  failure: Color(0xFFFFCACA),
  onFailure: Color(0xFF191D21),
  success: Color(0xFFBAEDE1),
  onSuccess: Color(0xFF191D21),
);

TextTheme _textTheme(ColorScheme colorScheme) {
  return TextTheme(
    displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
    displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
    headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
  );
}

SnackBarThemeData _snackBarThemeData(ColorScheme colorScheme) {
  return SnackBarThemeData(
    backgroundColor: colorScheme.primary,
    insetPadding: const EdgeInsets.fromLTRB(Spacing.normal, Spacing.normal, Spacing.normal, Spacing.small),
    shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small),
    behavior: SnackBarBehavior.floating,
    elevation: 8,
    actionTextColor: colorScheme.onPrimary,
    disabledActionTextColor: colorScheme.onSurfaceVariant,
  );
}

DialogThemeData _dialogTheme(ColorScheme colorScheme) {
  return DialogThemeData(
    backgroundColor: colorScheme.surface,
    shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small),
    elevation: 4,
    barrierColor: Colors.black.withAlpha(70),
  );
}

BottomSheetThemeData _bottomSheetThemeData(ColorScheme colorScheme) {
  return BottomSheetThemeData(
    elevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    modalBackgroundColor: colorScheme.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(RadiusValues.xLarge)),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    dragHandleColor: colorScheme.surfaceContainerLow,
    dragHandleSize: Size(60, 4),
  );
}

DatePickerThemeData _datePickerThemeData(ColorScheme colorScheme) {
  return DatePickerThemeData(
    shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
    headerBackgroundColor: colorScheme.primary,
    headerForegroundColor: colorScheme.onPrimary,
  );
}

TimePickerThemeData _timePickerThemeData(ColorScheme colorScheme) {
  return TimePickerThemeData(
    shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
    backgroundColor: colorScheme.surface,
    padding: const EdgeInsets.all(16),
    dialBackgroundColor: colorScheme.surfaceContainer,
  );
}

ScrollbarThemeData _scrollbarThemeData(ColorScheme colorScheme) {
  return ScrollbarThemeData(
    thickness: const WidgetStatePropertyAll(Spacing.xSmall),
    thumbColor: WidgetStatePropertyAll(colorScheme.onSurfaceVariant),
    mainAxisMargin: Spacing.small,
    radius: RadiusValues.xSmall,
    crossAxisMargin: 2,
    interactive: true,
  );
}

PopupMenuThemeData _popupMenuThemeData(ColorScheme colorScheme) {
  return PopupMenuThemeData(
    color: colorScheme.surface,
    elevation: 10,

    shadowColor: colorScheme.onSurface.withAlpha(10),
    shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small),
    position: PopupMenuPosition.under,
  );
}

AppBarTheme _appBarTheme(ColorScheme colorScheme) {
  return AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: colorScheme.onSurface,
    scrolledUnderElevation: 0,
    centerTitle: false,
    elevation: 0,
    iconTheme: IconThemeData(color: colorScheme.onSurface),
    actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
    titleTextStyle: _textTheme(
      colorScheme,
    ).titleLarge?.copyWith(fontWeight: FontWeight.w500, letterSpacing: 1, color: colorScheme.onSurface),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: ThemeData.estimateBrightnessForColor(colorScheme.surface),
      statusBarIconBrightness: ThemeData.estimateBrightnessForColor(colorScheme.onSurface),
    ),
  );
}

BottomNavigationBarThemeData _bottomNavigationBarThemeData(ColorScheme colorScheme) {
  return BottomNavigationBarThemeData(
    backgroundColor: colorScheme.surface,
    selectedItemColor: colorScheme.primary,
    unselectedItemColor: colorScheme.onSurfaceVariant,
  );
}

ElevatedButtonThemeData _elevatedButtonThemeData(ColorScheme colorScheme) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      disabledBackgroundColor: colorScheme.primary.withAlpha(50),
      disabledForegroundColor: colorScheme.onPrimary,
      textStyle: _textTheme(colorScheme).titleMedium,
      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xLarge, vertical: Spacing.medium),
      minimumSize: Size(96, 60),
    ),
  );
}

OutlinedButtonThemeData _outlinedButtonThemeData(ColorScheme colorScheme) {
  return OutlinedButtonThemeData(
    style:
        OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.xLarge),
          textStyle: _textTheme(colorScheme).titleMedium?.copyWith(color: colorScheme.onSurface),
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xLarge, vertical: Spacing.medium),
          minimumSize: Size(96, 60),
          visualDensity: VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
        ).copyWith(
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: colorScheme.onSurfaceVariant.withAlpha(25));
            }
            return BorderSide(color: colorScheme.outline);
          }),
        ),
  );
}

FilledButtonThemeData _filledButtonThemeData(ColorScheme colorScheme) {
  return FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      disabledBackgroundColor: colorScheme.primary.withAlpha(50),
      disabledForegroundColor: colorScheme.onPrimary,
      textStyle: _textTheme(colorScheme).titleMedium,
      shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.xxLarge),
      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xLarge, vertical: Spacing.large),
      minimumSize: Size(96, 60),
    ),
  );
}

TextButtonThemeData _textButtonThemeData(ColorScheme colorScheme) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colorScheme.onSurface,
      shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small),
      textStyle: _textTheme(colorScheme).titleMedium?.copyWith(color: colorScheme.primary),
      padding: const EdgeInsets.symmetric(horizontal: Spacing.small, vertical: Spacing.xSmall),
      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      minimumSize: Size(0, 50),
    ),
  );
}

InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
  final border = OutlineInputBorder(
    borderRadius: ShapeBorderRadius.xxxLarge,
    borderSide: BorderSide(color: colorScheme.surfaceContainerLow),
  );
  return InputDecorationTheme(
    fillColor: colorScheme.onPrimary,
    filled: true,
    hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w400, fontSize: 12),
    errorStyle: _textTheme(colorScheme).bodySmall?.copyWith(fontWeight: FontWeight.w500, color: colorScheme.error),
    contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.medium),
    border: border,
    disabledBorder: border.copyWith(borderSide: BorderSide(color: colorScheme.surfaceContainerLow)),
    enabledBorder: border.copyWith(borderSide: BorderSide(color: colorScheme.surfaceContainerLow)),
    focusedBorder: border.copyWith(borderSide: BorderSide(color: colorScheme.primary)),
    focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: colorScheme.error)),
    errorBorder: border.copyWith(borderSide: BorderSide(color: colorScheme.error)),
  );
}
