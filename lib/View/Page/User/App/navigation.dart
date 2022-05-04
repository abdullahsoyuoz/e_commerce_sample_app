import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/constant.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
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
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 100);
    _pageController = PageController(viewportFraction: 0.3);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox.expand(
          child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }
          if (details.delta.dx < 0) {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }
        },
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              collapsedHeight: 60,
              pinned: true,
              automaticallyImplyLeading: false,
              title: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 41,
                  minHeight: 41,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: LineIcon(LineIcons.arrowLeft),
                    ),
                    Text(
                      'NAVIGASYON',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              centerTitle: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: SizedBox(
                  width: context.width,
                  height: 50,
                  child: PageView.builder(
                      controller: _pageController,
                      pageSnapping: true,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // padding: EdgeInsets.only(right: context.width * 0.7, left: 10),
                      itemCount: navigationMenu.length,
                      itemBuilder: (context, index) {
                        final data = navigationMenu[index];
                        return Center(
                          child: BouncingWidget(
                            onPressed: () {
                              setState(() {
                                currentPage = index;
                                _pageController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              });
                            },
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 20, minHeight: 20),
                              child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  data.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            currentPage == 0
                ? buildCategories()
                : const SliverToBoxAdapter(child: SizedBox()),
            currentPage == 1
                ? buildSettings(context)
                : const SliverToBoxAdapter(child: SizedBox()),
          ],
        ),
      )),
    );
  }

  Widget buildSettings(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
          bottom: 200,
        ),
        sliver: SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Karanlık Tema'),
              CupertinoSwitch(
                value:
                    Provider.of<ThemeChanger>(context, listen: false).isDark(),
                onChanged: (value) {
                  Provider.of<ThemeChanger>(context, listen: false).setTheme(value);
                },
              ),
            ],
          ),
        ));
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