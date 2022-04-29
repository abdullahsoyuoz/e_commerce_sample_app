import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/View/Style/Theme/themedata.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/category_widget.dart';
import 'package:sepet_demo/View/Widget/sticky_header.dart';

import '../../../Style/decorations.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
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
            
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            childAspectRatio: 1,
            children: categoryList.map((e) => CategoryWidget(data: e)).toList(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                child: Row(
                  children: themeList
                      .map(
                        (e) => IconButton(
                          onPressed: () {
                            Provider.of<ThemeChanger>(context, listen: false)
                                .setTheme(e);
                          },
                          icon: DecoratedBox(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: appShadow(context)),
                            child: CircleAvatar(
                              backgroundColor: e.appBarTheme.backgroundColor,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        ],
      )),
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