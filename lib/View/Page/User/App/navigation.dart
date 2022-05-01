import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/constant.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/View/Painter/fade_painter.dart';
import 'package:sepet_demo/View/Style/Theme/themedata.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/category_widget.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController _scrollController;
  int currentPage = 0;

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 100);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SizedBox.expand(
          child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            collapsedHeight: 60,
            pinned: true,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: LineIcon(LineIcons.arrowLeft)),
                Text(
                  'NAVIGASYON',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: SizedBox(
                width: context.width,
                height: 50,
                child: CustomPaint(
                  foregroundPainter: FadePainter(
                    fadeColor: Theme.of(context).appBarTheme.backgroundColor!,
                    context: context,
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding:
                          EdgeInsets.only(right: context.width * 0.7, left: 10),
                      itemCount: navigationMenu.length,
                      itemBuilder: (context, index) {
                        final data = navigationMenu[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: SizedBox(
                            width: context.width * 0.3,
                            child: BouncingWidget(
                              onPressed: () {
                                setState(() {
                                  currentPage = index;
                                });
                              },
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxHeight: 10, minHeight: 10),
                                child: FittedBox(
                                  alignment: Alignment.center,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    data.toString(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ),
          currentPage == 0
              ? buildCategories()
              : const SliverToBoxAdapter(child: SizedBox()),
          currentPage == 1
              ? buildThemes(context)
              : const SliverToBoxAdapter(child: SizedBox()),
        ],
      )),
    );
  }

  Widget buildThemes(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        top: 5,
        left: 5,
        right: 5,
        bottom: 200,
      ),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        // crossAxisSpacing: 5,
        // mainAxisSpacing: 5,
        children: themeList.map((e) {
          return BouncingWidget(
              onPressed: () {
                Provider.of<ThemeChanger>(context, listen: false).setTheme(e);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: e.appBarTheme.backgroundColor!,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          key: LabeledGlobalKey(e.hashCode.toString()),
                          // color: e.floatingActionButtonTheme.backgroundColor,
                          // splashColor: e.floatingActionButtonTheme.splashColor,
                          style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(40, 40)),
                            maximumSize:
                                MaterialStateProperty.all(const Size(40, 40)),
                            minimumSize:
                                MaterialStateProperty.all(const Size(40, 40)),
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            shape: MaterialStateProperty.all(
                                const StadiumBorder()),
                            elevation: MaterialStateProperty.all(5),
                            overlayColor: MaterialStateProperty.all(
                                e.splashColor),
                            backgroundColor: MaterialStateProperty.all(
                                e.floatingActionButtonTheme.backgroundColor),
                            foregroundColor: MaterialStateProperty.all(
                                e.floatingActionButtonTheme.foregroundColor),
                          ),
                          onPressed: () {},
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.icons,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Lorem ipsum',
                        style: TextStyle(
                          fontSize: 17,
                          color: e.textTheme.bodyText2!.color,
                        ),
                      ),
                    )
                  ],
                ),
              ));
        }).toList(),
      ),
    );
  }

  Widget buildCategories() {
    return SliverPadding(
      padding: const EdgeInsets.only(
        top: 5,
        left: 5,
        right: 5,
        bottom: 200,
      ),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        // crossAxisSpacing: 5,
        // mainAxisSpacing: 5,
        children: categoryList.map((e) => CategoryWidget(data: e)).toList(),
      ),
    );
  }
}


// Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: FittedBox(
//                 alignment: Alignment.center,
//                 fit: BoxFit.fitWidth,
//                 child: Row(
//                   children: themeList
//                       .map(
//                         (e) => IconButton(
//                           onPressed: () {
//                             Provider.of<ThemeChanger>(context, listen: false)
//                                 .setTheme(e);
//                           },
//                           icon: DecoratedBox(
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 boxShadow: appShadow(context)),
//                             child: CircleAvatar(
//                               backgroundColor: e.appBarTheme.backgroundColor,
//                             ),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ),