import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/constant.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
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
  // DUMMY
  bool notify = true;

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
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 70 + context.padding.top, bottom: 100),
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Kategoriler',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 27),
                  ),
                ),
                SizedBox(
                  width: context.width,
                  height: context.width * 0.9,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 30),
                    itemCount: categoryList.length,
                    itemBuilder: (_, index) {
                      final data = categoryList[index];
                      return AspectRatio(
                        aspectRatio: 0.6,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 17),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: BouncingWidget(
                                    onPressed: () {},
                                    child: Card(
                                      elevation: 10,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: appRadius(context)),
                                      child: ClipRRect(
                                        borderRadius: appRadius(context),
                                        child: Image.network(
                                          data.imageUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Ayarlar',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 27),
                  ),
                ),
                SizedBox(
                  width: context.width,
                  height: context.width * 0.7,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 30),
                    children: [
                      AspectRatio(
                        aspectRatio: 0.6,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Karanlık Tema',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 17),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: BouncingWidget(
                                    onPressed: () {},
                                    child: Card(
                                      elevation: 10,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: appRadius(context)),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: appRadius(context),
                                          child: CupertinoSwitch(
                                            value: Provider.of<ThemeChanger>(
                                                    context,
                                                    listen: false)
                                                .isDark(),
                                            onChanged: (value) {
                                              Provider.of<ThemeChanger>(context,
                                                      listen: false)
                                                  .setTheme(value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 0.6,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bildirimler',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 17),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: BouncingWidget(
                                    onPressed: () {},
                                    child: Card(
                                      elevation: 10,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: appRadius(context)),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: appRadius(context),
                                          child: CupertinoSwitch(
                                            value: notify,
                                            onChanged: (value) {
                                              setState(() {
                                                notify = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Destek ve Bilgi',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 27),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.width,
                  height: context.width * 0.7,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 30),
                    children: [
                      AspectRatio(
                        aspectRatio: 0.6,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bize ulaş',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 17),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: BouncingWidget(
                                    onPressed: () {},
                                    child: Card(
                                      elevation: 10,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: appRadius(context)),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: appRadius(context),
                                          child: LineIcon(LineIcons.headset, size: 60,)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 0.6,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kişisel verilerin korunması',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 17),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: BouncingWidget(
                                    onPressed: () {},
                                    child: Card(
                                      elevation: 10,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: appRadius(context)),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: appRadius(context),
                                          child: LineIcon(LineIcons.fileContract, size: 60,)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: navAppBar(context),
            )
          ],
        ),
      ),
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
                  Provider.of<ThemeChanger>(context, listen: false)
                      .setTheme(value);
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
        bottom: 100,
      ),
      sliver: SliverGrid.count(
        crossAxisCount: 1,
        childAspectRatio: 2,
        // crossAxisSpacing: 5,
        // mainAxisSpacing: 5,
        children: categoryList.map((e) => CategoryWidget(data: e)).toList(),
      ),
    );
  }

  PreferredSize navAppBar(BuildContext context) {
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
                  .backgroundColor!
                  .withOpacity(0.1),
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  IconButton(
                    icon: FaIcon(
                      LineIcons.arrowLeft,
                      color: Theme.of(context).iconTheme.color!,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text('combin'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
