import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/Constant/constant.dart';
import 'package:sepet_demo/Controller/Constant/languages.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Controller/Provider/theme_provider.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/Model/category.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;
  AnimationController _openAnimationController;
  // DUMMY
  bool notify = true;

  @override
  void initState() {
    _scrollController = ScrollController();
    _openAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _openAnimationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _openAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _openAnimationController,
        builder: (context, _) {
          return Scaffold(
            key: _scaffoldKey,
            body: SizedBox.expand(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                        top: 70 + context.padding.top, bottom: 100),
                    children: [
                      _slideAnimate(
                        Direction.LEFT,
                        TitleWidget(title: languageConverter(context, "categories")),
                      ),
                      _slideAnimate(
                        Direction.RIGHT,
                        _buildCategories(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: _slideAnimate(
                          Direction.LEFT,
                          TitleWidget(title: languageConverter(context, "settings")),
                        ),
                      ),
                      _slideAnimate(
                        Direction.RIGHT,
                        _buildSettings(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: _slideAnimate(
                          Direction.LEFT,
                          TitleWidget(title: languageConverter(context, "support")),
                        ),
                      ),
                      _slideAnimate(
                        Direction.RIGHT,
                        _buildSupport(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: _slideAnimate(
                          Direction.LEFT,
                          TitleWidget(title: languageConverter(context, "applicationLanguage")),
                        ),
                      ),
                      _slideAnimate(Direction.DOWN, _buildLangList()),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: _slideAnimate(Direction.UP, _navAppBar()),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _buildLangList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      itemCount: languageList.length,
      itemBuilder: (context, index) {
        final data = languageList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: BouncingWidget(
                  duration: const Duration(milliseconds: 300),
                  onPressed: () {
                    SharedPreferences.getInstance().then((value) {
                      value.setString("lang", data.locale.languageCode);
                      AppLocalizations.of(context).load();
                      setState(() {});
                    });
                  },
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(data.icon),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    data.title,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 21,
                        ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _navAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3,
            sigmaY: 3,
          ),
          child: SizedBox(
            height: 70 + context.padding.top,
            child: AppBar(
              toolbarHeight: 70,
              centerTitle: false,
              elevation: 0,
              backgroundColor: Theme.of(context)
                  .appBarTheme
                  .backgroundColor
                  .withOpacity(0.1),
              automaticallyImplyLeading: false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: LineIcon(
                      LineIcons.arrowLeft,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                'COMBIN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, fontFamily: 'Futura'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: LogoWidget(
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 60,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: LogoWidget(
                  //       size: 50,
                  //       color: Theme.of(context).iconTheme.color,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return AspectRatio(
      aspectRatio: 1.6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        controller: _scrollController,
        padding: const EdgeInsets.only(left: 30),
        physics: const BouncingScrollPhysics(),
        itemCount: categoryList.length,
        itemBuilder: (_, index) {
          final data = categoryList[index];
          return buildCategoryItem(data);
        },
      ),
    );
  }

  Widget buildCategoryItem(Category data) {
    return AspectRatio(
      aspectRatio: 0.625,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BouncingWidget(
              onPressed: () {},
              child: Card(
                child: ClipRRect(
                  borderRadius: appRadius(),
                  child: Image.asset(
                    'assets/image/categories/${data.categoryId}${data.id}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Divider(
                color: data.color,
                thickness: 1,
                height: 0,
              ),
            ),
            Flexible(
              child: Marquee(
                crossAxisAlignment: CrossAxisAlignment.start,
                numberOfRounds: 1,
                scrollAxis: Axis.horizontal,
                fadingEdgeStartFraction: 0.05,
                fadingEdgeEndFraction: 0.1,
                showFadingOnlyWhenScrolling: true,
                velocity: 30,
                decelerationDuration: const Duration(seconds: 3),
                startAfter: const Duration(seconds: 1),
                startPadding: 0.1,
                blankSpace: context.width * 0.2,
                text: languageConverter(context, data.title),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: AspectRatio(
        aspectRatio: 3,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 30),
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BouncingWidget(
                      onPressed: () {
                        Provider.of<ThemeChanger>(context, listen: false)
                            .toggle();
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Card(
                          color: Theme.of(context).iconTheme.color,
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: FittedBox(
                              child: LineIcon(
                                Provider.of<ThemeChanger>(context,
                                            listen: false)
                                        .isDark()
                                    ? LineIcons.sun
                                    : LineIcons.moon,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      languageConverter(context, "theme"),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 21),
                    ),
                  ),
                ],
              ),
            ),
            buildSettingsItem(languageConverter(context, "notify"), LineIcons.bell),
            buildSettingsItem(languageConverter(context, "editProfile"), LineIcons.user),
          ],
        ),
      ),
    );
  }

  Padding buildSettingsItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BouncingWidget(
              onPressed: () {},
              child: AspectRatio(
                aspectRatio: 1,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: FittedBox(child: LineIcon(icon)),
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              title,
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 21),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupport() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        buildSupportItem(languageConverter(context, "contactUs"), LineIcons.headset),
        buildSupportItem(languageConverter(context, "orderHelp"), LineIcons.truckLoading),
        buildSupportItem(languageConverter(context, "myReviews"), LineIcons.certificate),
        buildSupportItem(languageConverter(context, "feedback"), LineIcons.grinningFace),
        buildSupportItem(languageConverter(context, "protectPersonalData"), LineIcons.fileContract),
        buildSupportItem(languageConverter(context, "aboutUs"), LineIcons.identificationBadge),
      ],
    );
  }

  Widget buildSupportItem(String title, IconData icon, {int index}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: BouncingWidget(
              onPressed: () {},
              child: Card(
                child: AspectRatio(aspectRatio: 1, child: LineIcon(icon)),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 21,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //

  Widget _slideAnimate(Direction direction, Widget child) {
    return AnimatedOpacity(
      opacity: _openAnimationController.value,
      duration: const Duration(milliseconds: 300),
      child: SlideTransition(
        position: Tween<Offset>(
                begin: direction == Direction.LEFT
                    ? const Offset(-0.75, 0)
                    : direction == Direction.RIGHT
                        ? const Offset(0.75, 0)
                        : direction == Direction.UP
                            ? const Offset(0, -0.75)
                            : const Offset(0, 0.75),
                end: Offset.zero)
            .animate(CurvedAnimation(
                parent: _openAnimationController, curve: Curves.ease)),
        child: child,
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: 35,
            foreground: Paint()
              ..style = PaintingStyle.fill
              ..color = Theme.of(context).iconTheme.color),
      ),
    );
  }
}
