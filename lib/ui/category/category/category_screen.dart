part of 'category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String routeName = '/category';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryProvider(context: context),
      child: CategoryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CategoryProvider>();
    return Scaffold(
      appBar: NewsPayAppbar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Inshorts", style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            Text(
              "Choose a category to explore quick insights",
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colorScheme.surfaceTint,
              ),
            ),
          ],
        ),
        showBack: false,
      ),
      body: DynamicHeightGridView(
        builder: (context, index) {
          return _CategoryCell(category: provider.categories[index]);
        },
        itemCount: provider.categories.length,
        crossAxisCount: 2,
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.only(
            top: Spacing.normal, right: Spacing.medium, left: Spacing.medium ,bottom: Spacing.xxxLarge),
        mainAxisSpacing: Spacing.medium,
        crossAxisSpacing: Spacing.medium,
      ),
    );
  }
}

class _CategoryCell extends StatelessWidget {
  final Category category;

  const _CategoryCell({required this.category});

  @override
  Widget build(BuildContext context) {
    return CommonButton.cupertino(
      onTap: () {
        context.navigator.pushNamed(NewsScreen.routeName, arguments: category);
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(color: category.color, borderRadius: ShapeBorderRadius.normal),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: ShapeBorderRadius.normal,
                child: Image.asset(category.img, fit: BoxFit.cover),
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.all(Spacing.medium),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [category.color, Colors.transparent],
                    begin: AlignmentGeometry.bottomLeft,
                    end: AlignmentGeometry.topRight,
                    stops: [.4, 2],
                  ),
                  borderRadius: ShapeBorderRadius.normal,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(Spacing.small),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: context.colorScheme.onPrimary.withColorOpacity(.1)),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        category.icon,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(context.colorScheme.onPrimary, BlendMode.srcIn),
                      ),
                    ),
                    Gap(Spacing.normal),
                    Text(
                      category.label,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      category.info,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onPrimary.withColorOpacity(.7),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
