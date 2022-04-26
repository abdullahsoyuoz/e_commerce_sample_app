import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Widget/category_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController(
      initialScrollOffset: 100,
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
        actions: [
          CupertinoSwitch(
            value: Provider.of<ThemeChanger>(context, listen: false).isDark,
            onChanged: (val) {
              Provider.of<ThemeChanger>(context, listen: false).toggle();
              setState(() {});
            },
          )
        ],
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.only(bottom: context.padding.bottom),
          child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            physics: const PageScrollPhysics(),
            itemExtent: safeArea(context) * 1/8,
            itemCount: categoryList.length,
            itemBuilder: (context, index) =>
                CategoryWidget(data: categoryList[index]),
          ),
        ),
      ),
    );
  }
}
