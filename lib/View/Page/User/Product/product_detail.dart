// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Widget/stacked_carousel.dart';
import 'package:sepet_demo/View/Widget/sliver_persistent.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailPage extends StatefulWidget {
  final Product data;
  final PaletteGenerator palette;
  const ProductDetailPage({Key key, this.data, this.palette}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController;
  PageController _customScrollViewController;
  bool showBackToTop = false;

  @override
  void initState() {
    _pageController = PageController();
    _customScrollViewController = PageController()
      ..addListener(() {
        setState(() {
          if (_customScrollViewController.position.pixels > 300) {
              showBackToTop = true;
          } else {
              showBackToTop = false;
          }
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _customScrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          bottom: false,
          child: SizedBox.expand(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  bottom: context.padding.bottom + 50,
                  child: Material(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(60),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(60),
                      ),
                      child: CustomScrollView(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        controller: _customScrollViewController,
                        slivers: [
                          SliverAppBar(
                            toolbarHeight: 0,
                            expandedHeight: 300,
                            collapsedHeight: 70,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(30))),
                            automaticallyImplyLeading: false,
                            stretch: true,
                            snap: false,
                            pinned: false,
                            floating: false,
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              stretchModes: const [StretchMode.blurBackground],
                              background: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: StackedCarousel(
                                      itemAspectRatio: context.width / (280),
                                      aspectRatio: context.width / (280),
                                      verticalScrolling: false,
                                      reverse: false,
                                      padding: 0,
                                      incrementalVerticalPadding: 40,
                                      pageControllerCallback: (c) {
                                        _pageController = c;
                                      },
                                      itemCount: widget.data.photosUrl.length,
                                      itemBuilder: (context, index) {
                                        final data =
                                            widget.data.photosUrl[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: Card(
                                            elevation: 10,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        bottom: Radius.circular(
                                                            30)),
                                                child: Image.network(data,
                                                    fit: BoxFit.cover)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SmoothPageIndicator(
                                      controller: _pageController,
                                      count: widget.data.photosUrl.length,
                                      effect: ExpandingDotsEffect(
                                        activeDotColor:
                                            Theme.of(context).iconTheme.color,
                                        dotColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                      onDotClicked: (page) {
                                        _pageController.animateToPage(
                                          page,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          MultiSliver(
                            pushPinnedChildren: true,
                            children: [
                              SliverPersistentHeader(
                                pinned: true,
                                floating: false,
                                key: LabeledGlobalKey('productOverview'),
                                delegate: CustomSliverPersistentHeader(context,
                                    maxExtentValue: context.padding.top * 2,
                                    minExtentValue: context.padding.top * 2,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.data.title,
                                              style: TextStyle(
                                                fontSize: 30,
                                              ),
                                            ),
                                            Text(
                                              widget.data.brand,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  height: 1,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .outline),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                              SliverList(
                                  delegate: SliverChildListDelegate.fixed(
                                      List.generate(
                                5,
                                (index) => SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(index.toString()),
                                  ),
                                ),
                              )))
                            ],
                          ),
                          MultiSliver(
                            pushPinnedChildren: true,
                            children: [
                              SliverPersistentHeader(
                                pinned: true,
                                floating: false,
                                key: LabeledGlobalKey('specs'),
                                delegate: CustomSliverPersistentHeader(context,
                                    maxExtentValue: context.padding.top * 2,
                                    minExtentValue: context.padding.top * 2,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Ürün Özellikleri",
                                          style: TextStyle(
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              SliverList(
                                  delegate: SliverChildListDelegate.fixed(
                                      List.generate(
                                5,
                                (index) => SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(index.toString()),
                                  ),
                                ),
                              )))
                            ],
                          ),
                          MultiSliver(
                            pushPinnedChildren: true,
                            children: [
                              SliverPersistentHeader(
                                pinned: true,
                                floating: false,
                                key: LabeledGlobalKey('supplier'),
                                delegate: CustomSliverPersistentHeader(context,
                                    maxExtentValue: context.padding.top * 2,
                                    minExtentValue: context.padding.top * 2,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Satıcılar",
                                          style: TextStyle(
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              SliverList(
                                  delegate: SliverChildListDelegate.fixed(
                                      List.generate(
                                5,
                                (index) => SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(index.toString()),
                                  ),
                                ),
                              )))
                            ],
                          ),
                          MultiSliver(
                            pushPinnedChildren: true,
                            children: [
                              SliverPersistentHeader(
                                pinned: true,
                                floating: false,
                                key: LabeledGlobalKey('payment'),
                                delegate: CustomSliverPersistentHeader(context,
                                    maxExtentValue: context.padding.top * 2,
                                    minExtentValue: context.padding.top * 2,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Ödeme Seçenekleri",
                                          style: TextStyle(
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              SliverList(
                                  delegate: SliverChildListDelegate.fixed(
                                      List.generate(
                                5,
                                (index) => SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(index.toString()),
                                  ),
                                ),
                              )))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                buildBottomController(context),
              ],
            ),
          ),
        ));
  }

  Widget buildBottomController(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: context.padding.bottom),
        child: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    LineIcons.arrowLeft,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Beğen',
                      child: IconButton(
                        icon: const Icon(
                          LineIcons.heart,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Tooltip(
                      message: 'Listene Ekle',
                      child: IconButton(
                        icon: const Icon(
                          LineIcons.bookmark,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Tooltip(
                      message: 'Sepete Ekle',
                      child: IconButton(
                        icon: const Icon(
                          LineIcons.shoppingBag,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                buildShowBackToTop(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildShowBackToTop() {
    return AbsorbPointer(
      absorbing: !showBackToTop,
      child: Tooltip(
        message: "Başa Dön",
        triggerMode: TooltipTriggerMode.longPress,
        child: IconButton(
            onPressed: backToTop,
            icon: Icon(
              LineIcons.arrowUp,
              color: showBackToTop
                  ? Theme.of(context).iconTheme.color
                  : Colors.transparent,
            )),
      ),
    );
  }

  void backToTop() {
    _customScrollViewController.animateTo(0,
        duration: Duration(milliseconds: 750), curve: Curves.ease);
  }
}
