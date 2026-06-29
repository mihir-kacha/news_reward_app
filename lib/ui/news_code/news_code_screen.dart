part of 'news_code.dart';

class NewsCodeScreen extends StatelessWidget {
  const NewsCodeScreen({super.key});

  static const String routeName = '/news_code';

  static Widget builder(BuildContext context) {
    final newsData = context.args;
    return ChangeNotifierProvider(
      create: (context) => NewsCodeProvider(
        context: context,
        newsData: newsData,
        userRepository: UserRepository(uid: Preference().userId ?? ""),
        loadingDialogHandler: LoadingDialogHandler(context: context),
      ),
      child: NewsCodeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewsCodeProvider>();
    return Scaffold(
      appBar: NewsPayAppbar(title: Text(provider.newsData.title ?? "")),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewsCodeProvider>();
    final isLoading = context.select<NewsCodeProvider, bool>((value) => value.isLoading);
    final news = provider.newsData;
    return SingleChildScrollView(
      padding: EdgeInsets.all(Spacing.normal),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: NetworkImageBuilder(
                    url: news.imageUrl,
                    radius: ShapeBorderRadius.medium,
                    boxFit: BoxFit.cover,
                    placeholderBuilder: (context) {
                      return Container(
                        color: context.colorScheme.primary.withColorOpacity(.03),
                        child: Center(child: Icon(Icons.newspaper)),
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    width: context.width,
                    padding: EdgeInsets.all(Spacing.small),
                    decoration: BoxDecoration(
                      color: context.colorScheme.shadow.withColorOpacity(.7),
                      borderRadius: ShapeBorderRadius.medium,
                    ),
                    child: Text(
                      news.title ?? "",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                CommonButton.cupertino(
                  onTap: provider.showNews,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.medium, vertical: Spacing.small),
                    decoration: BoxDecoration(color: context.colorScheme.shadow, borderRadius: ShapeBorderRadius.small),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.insert_link_sharp, color: context.colorScheme.onPrimary),
                        Gap(Spacing.small),
                        Text(
                          "Read News Again",
                          style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(Spacing.normal),
          Form(
            key: provider.formKey,
            child: Container(
              width: context.width,
              padding: EdgeInsets.all(Spacing.normal),
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                borderRadius: ShapeBorderRadius.normal,
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.shadow.withColorOpacity(.08),
                    spreadRadius: 0,
                    offset: Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Enter Code & Claim 300 Points",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.shadow,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(Spacing.medium),
                  AppInputField(
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    controller: provider.codeController,
                    filled: true,
                    fillColor: context.colorScheme.outlineVariant,
                    borderRadius: Spacing.medium,
                    borderColor: context.colorScheme.shadow.withColorOpacity(.2),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
                      child: Icon(Icons.lock, color: context.colorScheme.primary),
                    ),
                    suffix: CommonButton.cupertino(
                      onTap: () {
                        HapticFeedback.vibrate();
                        Clipboard.setData(ClipboardData(text: (provider.codeController.value).toString()));
                      },
                      child: Icon(Icons.content_paste, color: context.colorScheme.shadow),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "Enter Code";
                      }
                      if (news.code != int.parse(provider.codeController.text)) {
                        return "Enter Valid Code";
                      }
                      return null;
                    },
                  ),
                  Gap(Spacing.medium),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      fixedSize: Size.fromWidth(context.width),
                      shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
                    ),
                    onPressed: isLoading ? null : provider.earnCoins,
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "Submit code & Earn 300 Points",
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                  Gap(Spacing.medium),
                  Text(
                    "4-digit code appears at the bottom of the news article. enter it below to verify and earn your reward",
                    style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.surfaceTint),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
