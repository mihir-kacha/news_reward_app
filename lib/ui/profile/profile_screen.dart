part of 'profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(
        context: context,
        loadingDialogHandler: LoadingDialogHandler(context: context),
        authRepository: AuthRepository(),
      ),
      child: ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsPayAppbar(title: Text(Preference().userInfo.name), showBack: false),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(Spacing.normal),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [NewsPayCoinCard(), Gap(Spacing.medium), _ProfileAction()],
        ),
      ),
    );
  }
}

class _ProfileAction extends StatelessWidget {
  const _ProfileAction();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProfileProvider>();
    return Container(
      padding: EdgeInsets.all(Spacing.medium),
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: ShapeBorderRadius.medium,
        boxShadow: [
          BoxShadow(color: context.colorScheme.shadow.withColorOpacity(.1), blurRadius: 6, offset: Offset(0, 0)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ActionCell(
            icon: Assets.icons.profile.icRefer.path,
            color: Color(0XFFee9f10),
            title: "Refer & Earn",
            subTitle: "Invite friends & earn rewards",
            onTap: () {
              context.navigator.pushNamed(ReferScreen.routeName);
            },
          ),
          // _Divider(),
          // _ActionCell(
          //   icon: Assets.icons.profile.icShare.path,
          //   color: Color(0XFF0fba80),
          //   title: "Share App",
          //   subTitle: "Share with friend and family",
          //   onTap: () async {
          //     await SharePlus.instance.share(ShareParams(text: 'Check out this awesome app!', subject: 'My App'));
          //   },
          // ),
          _Divider(),
          _ActionCell(
            icon: Assets.icons.profile.icPrivacy.path,
            color: Color(0XFF8d59ff),
            title: "Privacy Policy",
            subTitle: "How we protect your data",
            onTap: () {
              CommonFunc.openUrl(url: AppConstants.privacyPolicyUrl);
            },
          ),
          _Divider(),
          _ActionCell(
            icon: Assets.icons.profile.icTerm.path,
            color: Color(0XFFde4d9b),
            title: "Terms & Conditions",
            subTitle: "Read our rules & usage guidelines",
            onTap: () {
              CommonFunc.openUrl(url: AppConstants.termsAndConditions);
            },
          ),
          _Divider(),
          _ActionCell(
            icon: Assets.icons.profile.icRate.path,
            color: Color(0XFFf8c02c),
            title: "Rate us",
            subTitle: "Love our app? Rate us on the store",
            onTap: () {
              CommonFunc.openUrl(url: AppConstants.rateUsUrl);
            },
          ),
          _Divider(),
          _ActionCell(
            icon: Assets.icons.profile.icLogout.path,
            color: Color(0XFFf14443),
            title: "Logout",
            subTitle: "Securely end your session",
            onTap: () {
              ExitSheet.show(context: context, onDone: provider.onLogout);
            },
          ),
        ],
      ),
    );
  }
}

class _ActionCell extends StatelessWidget {
  final String icon;
  final Color color;
  final String title;
  final String subTitle;
  final VoidCallback onTap;

  const _ActionCell({
    required this.icon,
    required this.color,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonButton.cupertino(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.medium),
            decoration: BoxDecoration(color: color.withColorOpacity(.12), borderRadius: ShapeBorderRadius.medium),
            child: SvgPicture.asset(icon, width: 18, height: 18, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
          ),
          Gap(Spacing.small),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.shadow)),
                Text(
                  subTitle,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.surfaceTint.withColorOpacity(.8),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Gap(Spacing.small),
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLow,
              borderRadius: ShapeBorderRadius.small,
            ),
            child: Icon(Icons.arrow_forward_ios_rounded, color: context.colorScheme.surfaceTint),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(color: context.colorScheme.surfaceTint.withColorOpacity(.2), endIndent: 0, indent: 50, height: 30);
  }
}
