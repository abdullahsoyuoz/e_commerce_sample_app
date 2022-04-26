import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
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
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          automaticallyImplyLeading: true,
          centerTitle: false,
          title: const Text('Navigasyon'),
          actions: [
            CupertinoSwitch(
              value: Provider.of<ThemeChanger>(context, listen: false).isDark,
              onChanged: (val) {
                Provider.of<ThemeChanger>(context, listen: false).toggle();
                setState(() {});
              },
            )
          ],
          bottom: const TabBar(
            tabs: [
              Text(
                'Kategoriler',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'Yapılandırmalar',
                style: TextStyle(fontSize: 17),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildConfigurationBody(){
    return const SizedBox();
  }

  Widget buildCategoriesBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.padding.bottom),
      child: ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        physics: const PageScrollPhysics(),
        itemExtent: (safeArea(context) -
                const TabBar(
                  tabs: [],
                ).preferredSize.height) *
            1 /
            8,
        itemCount: categoryList.length,
        itemBuilder: (context, index) =>
            CategoryWidget(data: categoryList[index]),
      ),
    );
  }
}
