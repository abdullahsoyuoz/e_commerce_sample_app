
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Style/themedata.dart';
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          automaticallyImplyLeading: true,
          centerTitle: false,
          title: const Text('Navigasyon'),
          bottom: TabBar(
            tabs: [
              Text(
                'Kategori',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 14),
              ),
              Text(
                'Yapılandırma',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 14),
              ),
              Text(
                'Yardım',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
        body: SizedBox.expand(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildCategoriesBody(context),
              buildConfigurationBody(),
              buildHelpBody(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildConfigurationBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.6,
                minWidth: context.width * 0.6,
              ),
              child: const FittedBox(
                  child: Text(
                'TEMA',
              ))),
          FittedBox(
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
        ],
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
