part of 'dashboard.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const String routeName = '/dashboard';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardProvider(context: context),
      child: DashboardScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.select<DashboardProvider, int>((value) => value.currentIndex);
    return Scaffold(
      bottomNavigationBar: Container(
        padding:
            EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.medium) +
            EdgeInsets.only(bottom: context.padding.bottom),
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withColorOpacity(.08),
              offset: Offset(0, 2),
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            _BottomBarItem(icon: Assets.icons.icNews.path, index: 0, title: "Home"),
            _BottomBarItem(icon: Assets.icons.icCategroy.path, index: 1, title: "Category"),
            _BottomBarItem(icon: Assets.icons.icTask.path, index: 2, title: "Task"),
            _BottomBarItem(icon: Assets.icons.icWallet.path, index: 3, title: "Wallet"),
            _BottomBarItem(icon: Assets.icons.icProfile.path, index: 4, title: "Profile"),
          ],
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeScreen.builder(context),
          CategoryScreen.builder(context),
          TaskScreen.builder(context),
          RedeemScreen.builder(context),
          ProfileScreen.builder(context),
        ],
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final String icon;
  final int index;
  final String title;

  const _BottomBarItem({required this.icon, required this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DashboardProvider>();
    final currentIndex = context.select<DashboardProvider, int>((value) => value.currentIndex);
    final isSelected = currentIndex == index;
    return Expanded(
      child: CommonButton.cupertino(
        onTap: () {
          provider.onSelectedTab(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              height: 18,
              width: 18,
              colorFilter: ColorFilter.mode(
                isSelected ? context.colorScheme.primary : context.colorScheme.shadow,
                BlendMode.srcIn,
              ),
            ),
            Gap(Spacing.xSmall),
            Text(
              title,
              style: context.textTheme.labelSmall?.copyWith(
                color: isSelected ? context.colorScheme.primary : context.colorScheme.shadow,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }
}
