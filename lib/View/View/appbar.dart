import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/View/Page/User/Product/category.dart';
import 'package:sepet_demo/View/Page/User/Product/search.dart';
import 'package:sepet_demo/View/Style/route_builder.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';

AppBar homeAppbar(BuildContext context) {
  return AppBar(
    toolbarHeight: 70,
    title: BouncingWidget(
      onPressed: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const SearchPage(),
            ));
      },
      child: Container(
        width: context.width * 0.6,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.foregroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AbsorbPointer(
              absorbing: true,
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    RotateAnimatedText('Ürünlerde ara'),
                    RotateAnimatedText('Kategorilerde ara'),
                    RotateAnimatedText('Kampanyalarda ara'),
                    RotateAnimatedText('Markalarda ara'),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 15,
              ),
            )
          ],
        ),
      ),
    ),
    centerTitle: true,
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: IconButton(
      iconSize: 30,
      icon: const FaIcon(
        FontAwesomeIcons.grip,
        size: 30,
      ),
      onPressed: () => Navigator.push(
          context, leftSlideRouteBuilder(context, const CategoriesPage())),
    ),
    actions: [
      IconButton(
        iconSize: 30,
        icon: const FaIcon(
          FontAwesomeIcons.bagShopping,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          // showWaitDialog(context, type: CustomProgressIndicatorType.clock);

          Provider.of<ThemeChanger>(context, listen: false).toggle();

          // Navigator.push(
          //     context,
          //     CupertinoPageRoute(
          //       builder: (context) => const BasketPage(),
          //       // builder: (context) =>  TestPage(),
          //     ));
        },
      ),
    ],
  );
}
