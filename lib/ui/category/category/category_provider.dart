part of 'category.dart';

final class CategoryProvider extends BaseProvider {
  CategoryProvider({required super.context});

  final List<Category> categories = Category.values;
}
