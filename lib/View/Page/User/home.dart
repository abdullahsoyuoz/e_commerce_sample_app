// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/Constant/flow_constants.dart';
import 'package:sepet_demo/Controller/Constant/home_search_hints.dart';
import 'package:sepet_demo/Controller/Constant/lottie_asset_constants.dart';
import 'package:sepet_demo/Controller/Provider/flows_provider.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Model/Dummy/user.dart';
import 'package:sepet_demo/View/Page/User/App/navigation.dart';
import 'package:sepet_demo/View/Page/User/Order/basket.dart';
import 'package:sepet_demo/View/Page/User/Product/search.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/View/dropmenu_low.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/drop_menu.dart';
import 'package:sepet_demo/View/Widget/flow_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';
import 'package:sepet_demo/View/Widget/search_frame.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController _animationController;
  late final PageController _pageController;
  late final ScrollController _listViewController;
  final RestorableInt currentPage = RestorableInt(0);

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.3);
    _listViewController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _listViewController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  String? get restorationId => 'flowPage';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(currentPage, 'currentPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const BasketPage(),
              ));
        },
        tooltip: 'Sepetin',
        child: const FaIcon(
          LineIcons.shoppingBasket,
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            DropMenu(
              animationController: _animationController,
              indicator: const SizedBox(),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              lowLayerBottomPadding: context.padding.bottom,
              lowLayerHeight: 70,
              lowLayer: const LowLayerWidget(),
              highLayer: ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: GestureDetector(onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 10) {
                    _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  }
                  if (details.delta.dx < 10) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  }
                }, child: Consumer<FlowsProvider>(builder: (context, value, _) {
                  return RefreshIndicator(
                    edgeOffset: context.padding.top + 120,
                    onRefresh: () async {
                      Provider.of<FlowsProvider>(context, listen: false)
                          .filterList();
                    },
                    backgroundColor: Colors.white,
                    color: AppColors.purple,
                    displacement: 0,
                    child: ListView.builder(
                      controller: _listViewController,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                        top: 120 + context.padding.top,
                        bottom: 100,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: value.getList().length,
                      itemExtent: context.width * 0.5,
                      itemBuilder: (context, index) {
                        final data = value.getList();
                        return FlowWidget(data: data[index]);
                      },
                    ),
                  );
                })),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: homeAppbar(context),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize homeAppbar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120),
      child: Consumer<FlowsProvider>(builder: (context, provider, _) {
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3,
              sigmaY: 3,
            ),
            child: SizedBox(
              width: context.width,
              height: 120 + context.padding.top,
              child: AppBar(
                toolbarHeight: 120,
                centerTitle: true,
                elevation: 0,
                backgroundColor: Theme.of(context)
                    .appBarTheme
                    .backgroundColor!
                    .withOpacity(0.8),
                automaticallyImplyLeading: false,
                title: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 250),
                  crossFadeState: provider.isLoading
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Lottie.asset(
                    Provider.of<ThemeChanger>(context, listen: false).isDark()
                        ? lottieSpinnerWhite
                        : lottieSpinnerPurple,
                    height: 120,
                  ),
                  secondChild: BouncingWidget(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const SearchPage(),
                          ));
                    },
                    child: SearchFrame(
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
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color),
                                        speed:
                                            const Duration(milliseconds: 75)),
                                  )
                                  .toList(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 3.0),
                            child: Icon(
                              LineIcons.search,
                              color: Colors.white,
                              size: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: FaIcon(
                    LineIcons.bars,
                    color: Theme.of(context).iconTheme.color!,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const NavigationPage(),
                        ));
                  },
                ),
                actions: [
                  Tooltip(
                    message: 'Hızlı erişimler',
                    child: IconButton(
                      iconSize: 50,
                      onPressed: () {
                        quickMenuToggle();
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
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: SizedBox(
                    width: context.width,
                    height: 50,
                    child:
                        Consumer<FlowsProvider>(builder: (context, value, _) {
                      return PageView.builder(
                        controller: _pageController,
                        pageSnapping: true,
                        physics: const PageScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        onPageChanged: (index) {
                          currentPage.value = index;
                          value.setFilterIndex(index);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: flowFilter.length,
                        itemBuilder: (context, index) {
                          final data = flowFilter[index];
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 20,
                                    minHeight: 20,
                                  ),
                                  child: FittedBox(
                                    alignment: Alignment.center,
                                    fit: BoxFit.fitHeight,
                                    child: Row(
                                      children: [
                                        Text(
                                          data.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    width: index == currentPage.value ? 10 : 0,
                                    height: index == currentPage.value ? 10 : 0,
                                    decoration: BoxDecoration(
                                        color: index == currentPage.value
                                            ? getFilterIndicatorColor(index)
                                            : Colors.transparent,
                                        borderRadius: appRadius()),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void quickMenuToggle() {
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
