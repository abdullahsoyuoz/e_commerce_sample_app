import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Style/Theme/themedata.dart';
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

  @override
  void initState() {
    _scrollController = ScrollController(
      initialScrollOffset: 300,
    );
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
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          automaticallyImplyLeading: true,
          centerTitle: false,
          title: const Text('Navigasyon'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
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
          )),
      body: SizedBox.expand(
        child: buildCategoriesBody(context)
      ),
    );
  }

  Widget buildCategoriesBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.padding.bottom),
      child: ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        physics: const PageScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 3),
        itemExtent: (safeArea(context) -
                const TabBar(
                  tabs: [],
                ).preferredSize.height) *
            (1 / 12),
        itemCount: categoryList.length,
        itemBuilder: (context, index) =>
            CategoryWidget(data: categoryList[index]),
      ),
    );
  }

  Widget buildHelpBody(BuildContext context) {
    return const SizedBox();
  }
}
