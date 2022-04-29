import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';
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
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox.expand(
          child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: context.padding.top,
          bottom: 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.6,
                minWidth: context.width * 0.6,
              ),
              child: const FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(
                  'KATEGORILER',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            buildCategoriesBody(context),
          ],
        ),
      )),
    );
  }

  Widget buildCategoriesBody(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 3),
      itemCount: categoryList.length,
      itemBuilder: (context, index) =>
          CategoryWidget(data: categoryList[index]),
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