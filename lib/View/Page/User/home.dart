import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/Dummy/flows.dart';
import 'package:sepet_demo/Model/Dummy/user.dart';
import 'package:sepet_demo/View/Page/User/Order/basket.dart';
import 'package:sepet_demo/View/Page/User/Product/navigation.dart';
import 'package:sepet_demo/View/Page/User/Product/search.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/View/dropmenu_low.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/drop_menu.dart';
import 'package:sepet_demo/View/Widget/flow_widget.dart';
import 'package:sepet_demo/View/Widget/rectangle_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;

  @override
  void initState() {
    if (mounted) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
      super.initState();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: DropMenu(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        lowLayerHeight: 40,
        lowLayerBottomPadding: MediaQuery.of(context).padding.bottom,
        lowLayer: const LowLayerWidget(),
        decoration: BoxDecoration(boxShadow: appShadow(context)),
        indicator: const SizedBox(),
        animationController: _animationController,
        highLayer: Scaffold(
          appBar: homeAppbar(context),
          body: Padding(
            padding: EdgeInsets.only(bottom: context.padding.bottom),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const PageScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: flowList.length,
              itemExtent: safeArea(context, extra: 40) * 0.25,
              itemBuilder: (context, index) {
                // if (list.isEmpty || list == []) {
                //   return const FlowShimmerWidget();
                // }
                return FlowWidget(data: flowList[index]);
              },
            ),
          ),
        ),
      ),
    );
  }

  void toggleDropMenu() {
    if (!_animationController.isAnimating && _animationController.value == 0) {
      _animationController.forward();
    }
    if (!_animationController.isAnimating && _animationController.value == 1) {
      _animationController.reverse();
    }
  }

  AppBar homeAppbar(BuildContext context) {
    List<String> searchHintList = [
      'Ürünlerde ara',
      'Kategorilerde ara',
      'Kampanyalarde ara',
      'Markalarda ara',
      'Listelerde ara',
    ];
    return AppBar(
      toolbarHeight: 70,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: BouncingWidget(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const SearchPage(),
              ));
        },
        child: RectangleContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AbsorbPointer(
                absorbing: true,
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: searchHintList
                      .map(
                        (title) => TypewriterAnimatedText(title,
                            cursor: '|',
                            textAlign: TextAlign.end,
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            speed: const Duration(milliseconds: 75)),
                      )
                      .toList(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 15,
                ),
              )
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BouncingWidget(
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: FaIcon(
                            FontAwesomeIcons.locationDot,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 20),
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Faker.instance.locale.address.cityName![Random()
                                        .nextInt(Faker.instance.locale.address
                                            .cityName!.length)] +
                                    ', ' +
                                    Faker.instance.locale.address.country![
                                        Random().nextInt(Faker.instance.locale
                                            .address.country!.length)] +
                                    '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: BouncingWidget(
                    onPressed: () => toggleDropMenu(),
                    child: Row(
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 20),
                            child: FittedBox(
                              alignment: Alignment.centerRight,
                              fit: BoxFit.fitHeight,
                              child: Text(
                                loginUser.name! + '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: FaIcon(
                            FontAwesomeIcons.solidUser,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      leading: IconButton(
        iconSize: 30,
        icon: const FaIcon(
          FontAwesomeIcons.bars,
          size: 30,
        ),
        onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const NavigationPage(),
            )),
      ),
      actions: [
        IconButton(
          iconSize: 30,
          icon: const FaIcon(
            FontAwesomeIcons.bagShopping,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const BasketPage(),
                  // builder: (context) =>  TestPage(),
                ));
          },
        ),
      ],
    );
  }
}
