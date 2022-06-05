// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Painter/vertical_half_painter.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';
import 'package:sepet_demo/View/Widget/stacked_carousel.dart';
import 'package:sepet_demo/View/Widget/sliver_persistent.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
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
        backgroundColor: widget.palette.dominantColor.color,
        body: SafeArea(
          bottom: false,
          child: SizedBox.expand(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  bottom: context.padding.bottom + 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: CustomScrollView(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        controller: _customScrollViewController,
                        slivers: [
                          buildAppbar(context),
                          buildProductOverview(context),
                          buildProductSpecs(context),
                          buildProductComments(context),
                          buildProductSuppliers(context),
                          buildPaymentMethods(context),
                          buildCombinationSuggestion(context),
                          buildInterestedSuggestion(context),
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

  Widget buildAppbar(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 0,
      expandedHeight: context.width / 1.6,
      collapsedHeight: 70,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
      automaticallyImplyLeading: false,
      stretch: true,
      snap: false,
      pinned: false,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: const [StretchMode.fadeTitle],
        background: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              StackedCarousel(
                itemAspectRatio: 1.6,
                aspectRatio: 1.6,
                verticalScrolling: false,
                reverse: false,
                padding: 0,
                incrementalVerticalPadding: 5,
                pageControllerCallback: (c) {
                  _pageController = c;
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    setState(() {});
                  });
                },
                itemCount: widget.data.photosUrl.length,
                itemBuilder: (context, index) {
                  final data = widget.data.photosUrl[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        data,
                        fit: BoxFit.cover,
                        loadingBuilder: loadingIndicator,
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.data.photosUrl.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 5,
                    activeDotColor: Theme.of(context).iconTheme.color,
                    dotColor: Theme.of(context).colorScheme.primaryContainer,
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
    );
  }

  Widget buildProductOverview(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: false,
      children: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          key: LabeledGlobalKey('productOverview'),
          delegate: CustomSliverPersistentHeader(context,
              maxExtentValue: context.padding.top * 1.5,
              minExtentValue: context.padding.top * 1.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.data.title,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            LineIcon(LineIcons.store,
                                size: 14,
                                color: Theme.of(context).colorScheme.outline),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                widget.data.shop,
                                style: TextStyle(
                                    fontSize: 12,
                                    height: 1,
                                    color:
                                        Theme.of(context).colorScheme.outline),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Text(
                      widget.data.brand,
                      style: TextStyle(
                          fontSize: 12,
                          height: 1,
                          color: Theme.of(context).colorScheme.outline),
                    ),
                  ],
                ),
              )),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    widget.data.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 12, fontStyle: FontStyle.normal),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 20,
                      maxHeight: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Tooltip(
                            message: languageConverter(context, "buyCount"),
                            triggerMode: TooltipTriggerMode.tap,
                            child: Row(children: [
                              FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                      NumberFormat.compact(locale: 'en_US')
                                          .format(widget.data.purchasesCount))),
                              Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Center(
                                          child: LineIcon(LineIcons.box)))),
                            ])),
                        const VerticalDivider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Tooltip(
                              message:
                                  languageConverter(context, "reviewsCount"),
                              triggerMode: TooltipTriggerMode.tap,
                              child: Row(children: [
                                FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                        NumberFormat.compact(locale: 'en_US')
                                            .format(widget.data.commentCount))),
                                Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Center(
                                            child:
                                                LineIcon(LineIcons.comment)))),
                              ])),
                        ),
                        const VerticalDivider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Tooltip(
                              message:
                                  languageConverter(context, "averagePoint"),
                              triggerMode: TooltipTriggerMode.tap,
                              child: Row(children: [
                                FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      widget.data.rank.oneDigitForRankString,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .color),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Center(
                                            child: LineIcon(LineIcons.star)))),
                              ])),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.data.discountRate == null
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Text(
                                widget.data.price.twoDigitForMoney,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      fontSize: 17,
                                      backgroundColor: AppColors.red.shade300,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                            ),
                      Text(
                        discountedCalculate(
                                widget.data.price, widget.data.discountRate)
                            .twoDigitForMoney,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 17,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildProductSpecs(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          key: LabeledGlobalKey('specs'),
          delegate: CustomSliverPersistentHeader(context,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Özellikler",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
              )),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fakeSpecs(),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: BouncingWidget(
                    duration: Duration(milliseconds: 300),
                    onPressed: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: AspectRatio(
                        aspectRatio: 1.6,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            AbsorbPointer(
                              child: WebView(
                                initialUrl: widget.data.productWebUrl,
                                gestureNavigationEnabled: true,
                                javascriptMode: JavascriptMode.unrestricted,
                                zoomEnabled: true,
                              ),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .iconTheme
                                    .color
                                    .withOpacity(.85),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(35.0),
                              child: Center(
                                  child: Text(
                                'Daha fazla bilgi almak için tıklatın',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        // SliverList(
        //     delegate: SliverChildListDelegate.fixed(List.generate(
        //   5,
        //   (index) => SizedBox(
        //     height: 200,
        //     child: Center(
        //       child: Text(index.toString()),
        //     ),
        //   ),
        // )))
      ],
    );
  }

  Column fakeSpecs() {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(flex: 1, child: Text("İşlemci")),
            Expanded(
              flex: 3,
              child: Text("Apple M1 16 çekirdekli Neural Engine"),
            ),
          ],
        ),
        Row(
          children: const [
            Expanded(child: Text("Hafıza")),
            Expanded(flex: 3, child: Text("16 Gigabyte")),
          ],
        ),
        Row(
          children: const [
            Expanded(child: Text("Depolama")),
            Expanded(
              flex: 3,
              child: Text("512 GB SSD depolama"),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildProductComments(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          key: LabeledGlobalKey('comments'),
          delegate: CustomSliverPersistentHeader(context,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Değerlendirmeler",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
              )),
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed(List.generate(
          5,
          (index) => SizedBox(
            height: 200,
            child: Center(
              child: Text(index.toString()),
            ),
          ),
        )))
      ],
    );
  }

  Widget buildProductSuppliers(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          key: LabeledGlobalKey('supplier'),
          delegate: CustomSliverPersistentHeader(context,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Satıcılar",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
              )),
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed(List.generate(
          5,
          (index) => SizedBox(
            height: 200,
            child: Center(
              child: Text(index.toString()),
            ),
          ),
        )))
      ],
    );
  }

  Widget buildPaymentMethods(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          key: LabeledGlobalKey('payment'),
          delegate: CustomSliverPersistentHeader(context,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Ödeme Seçenekleri",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
              )),
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed(List.generate(
          5,
          (index) => SizedBox(
            height: 200,
            child: Center(
              child: Text(index.toString()),
            ),
          ),
        )))
      ],
    );
  }

  Widget buildCombinationSuggestion(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          key: LabeledGlobalKey('combination'),
          delegate: CustomSliverPersistentHeader(context,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Kombinasyon Önerisi",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
              )),
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed(List.generate(
          5,
          (index) => SizedBox(
            height: 200,
            child: Center(
              child: Text(index.toString()),
            ),
          ),
        )))
      ],
    );
  }

  Widget buildInterestedSuggestion(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          key: LabeledGlobalKey('interesteded'),
          delegate: CustomSliverPersistentHeader(context,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Şunlar da ilgini çekebilir",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
              )),
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed(List.generate(
          5,
          (index) => SizedBox(
            height: 200,
            child: Center(
              child: Text(index.toString()),
            ),
          ),
        )))
      ],
    );
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
                  icon: Icon(
                    LineIcons.arrowLeft,
                    color: widget.palette.dominantColor.bodyTextColor
                        .withAlpha(255),
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
                        icon: Icon(
                          LineIcons.heart,
                          color: widget.palette.dominantColor.bodyTextColor
                              .withAlpha(255),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Tooltip(
                      message: 'Listene Ekle',
                      child: IconButton(
                        icon: Icon(
                          LineIcons.bookmark,
                          color: widget.palette.dominantColor.bodyTextColor
                              .withAlpha(255),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Tooltip(
                      message: 'Sepete Ekle',
                      child: IconButton(
                        icon: Icon(
                          LineIcons.shoppingBag,
                          color: widget.palette.dominantColor.bodyTextColor
                              .withAlpha(255),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                AbsorbPointer(
                  absorbing: !showBackToTop,
                  child: Tooltip(
                    message: "Başa Dön",
                    triggerMode: TooltipTriggerMode.longPress,
                    child: IconButton(
                        onPressed: backToTop,
                        icon: Icon(
                          LineIcons.arrowUp,
                          color: showBackToTop
                              ? widget.palette.dominantColor.bodyTextColor
                                  .withAlpha(255)
                              : Colors.transparent,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void backToTop() {
    _customScrollViewController.animateTo(
      0,
      duration: Duration(
          milliseconds:
              _customScrollViewController.position.pixels.toInt() ~/ 2),
      curve: Curves.ease,
    );
  }
}
