import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/Constant/app_menu_constants.dart';
import 'package:sepet_demo/Controller/Constant/constant.dart';
import 'package:sepet_demo/Controller/Constant/languages.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/Model/category.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/logo.dart';
import 'package:sepet_demo/View/Widget/menu_item.dart';
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
                  _slideAnimate(
                    Direction.DOWN,
                    ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                          top: 70 + context.padding.top, bottom: 100),
                      children: [
                        TitleWidget(
                            title: languageConverter(context, "categories")),
                        _buildCategories(),
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: TitleWidget(
                              title: languageConverter(context, "settings")),
                        ),
                        _buildSettings(),
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: TitleWidget(
                              title: languageConverter(context, "support")),
                        ),
                        _buildSupport(),
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: TitleWidget(
                              title: languageConverter(
                                  context, "applicationLanguage")),
                        ),
                        _buildLangList(),
                      ],
                    ),
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
                numberOfRounds: 2,
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
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      itemCount: settingsMenuItems.length,
      itemBuilder: (context, index) {
        final data = settingsMenuItems[index];
        return MenuItem(data: data);
      },
    );
  }

  Widget _buildSupport() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      itemCount: supportMenuItems.length,
      itemBuilder: (c, i) {
        final data = supportMenuItems[i];
        return MenuItem(data: data);
      },
    );
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 21),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //

  Widget _slideAnimate(Direction direction, Widget child) {
    return AnimatedOpacity(
      opacity: _openAnimationController.value,
      duration: const Duration(milliseconds: 450),
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
