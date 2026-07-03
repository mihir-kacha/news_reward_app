part of 'category.dart';

final class CategoryProvider extends BaseProvider {
  CategoryProvider({required super.context});

  final List<Category> categories = Category.values;

  @override
  void initState() {
    super.initState();
    resolveAdUnitId(
      slot: NativeAdTyped.detail,
      isThisAdPlaceEnable: preference.adsConfig?.adPlaceConfig?.categoryNative ?? false,
    );
  }
}
