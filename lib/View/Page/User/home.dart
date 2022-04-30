import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Controller/constant.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/Dummy/flows.dart';
import 'package:sepet_demo/Model/Dummy/user.dart';
import 'package:sepet_demo/View/Page/User/App/navigation.dart';
import 'package:sepet_demo/View/Page/User/Product/search.dart';
import 'package:sepet_demo/View/View/dropmenu_low.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/drop_menu.dart';
import 'package:sepet_demo/View/Widget/flow_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';
import 'package:sepet_demo/View/Widget/rectangle_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
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
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 5,
        child: FaIcon(
          LineIcons.shoppingBasket,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      body: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            fit: StackFit.expand,
            children: [
              DropMenu(
                animationController: _animationController,
                lowLayer: const LowLayerWidget(),
                indicator: const SizedBox(),
                highLayer: ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        top: 70 + context.padding.top, bottom: 100),
                    physics: const BouncingScrollPhysics(),
                    itemCount: flowList.length,
                    itemExtent: context.width * 0.5,
                    itemBuilder: (context, index) {
                      return FlowWidget(data: flowList[index]);
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: homeAppbar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize homeAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: SizedBox(
            width: context.width,
            height: 70 + context.padding.top,
            child: AppBar(
              toolbarHeight: 70,
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
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
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    speed: const Duration(milliseconds: 75)),
                              )
                              .toList(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: Icon(
                          LineIcons.search,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              leading: IconButton(
                  icon: const FaIcon(
                    LineIcons.bars,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const NavigationPage(),
                        ));
                  }),
              actions: [
                IconButton(
                  iconSize: 50,
                  onPressed: () {
                    toggle();
                  },
                  icon: AdvancedAvatar(
                    size: 50,
                    child: Image.network(
                      loginUser.photoUrl!,
                      loadingBuilder: loadingIndicator,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void toggle() {
    if (!_animationController.isAnimating) {
      if (_animationController.value == 0) {
        _animationController.forward();
      }
      if (_animationController.value == 1) {
        _animationController.reverse();
      }
    }
  }
}
