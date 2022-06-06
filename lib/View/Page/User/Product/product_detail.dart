// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/Provider/mylist_provider.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Clipper/star_rank_clipper.dart';
import 'package:sepet_demo/View/Page/User/Order/basket.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/View/Sheets/bookmark_sheet.dart';
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
  AnimationController _rankAnimationController;

  @override
  void initState() {
    _rankAnimationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 700) * widget.data.rank,
    );
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _rankAnimationController.animateTo(widget.data.rank / 5);
    });
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
    _rankAnimationController.dispose();
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
                incrementalVerticalPadding: 25,
                pageControllerCallback: (c) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    setState(() {
                      _pageController = c;
                    });
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
              maxExtentValue: context.padding.top * 2,
              minExtentValue: context.padding.top * 2,
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Tooltip(
                    message: languageConverter(context, "averagePoint"),
                    triggerMode: TooltipTriggerMode.tap,
                    child: SizedBox(
                      width: context.width,
                      height: 30,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.data.rank.oneDigitForRankString,
                            style: TextStyle(
                                fontSize: 20,
                                // height: 30,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .color),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Row(
                                          children: List.generate(
                                            5,
                                            (index) => LineIcon(
                                              LineIcons.starAlt,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipPath(
                                        clipper: StarRankPainter(
                                            rank: widget.data.rank,
                                            animationController:
                                                _rankAnimationController,
                                            animate: true),
                                        child: Center(
                                          child: Row(
                                            children: List.generate(
                                              5,
                                              (index) => LineIcon(
                                                  LineIcons.starAlt,
                                                  color:
                                                      AppColors.orange.shade200,
                                                  size: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
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
                              message: languageConverter(context, "forumCount"),
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
                                                LineIcon(LineIcons.comments)))),
                              ])),
                        ),
                        const VerticalDivider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Tooltip(
                              message:
                                  languageConverter(context, "questionCount"),
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
                                            child: LineIcon(
                                                LineIcons.commentDots)))),
                              ])),
                        ),
                        // const VerticalDivider(),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 3.0),
                        //   child: Tooltip(
                        //       message:
                        //           languageConverter(context, "averagePoint"),
                        //       triggerMode: TooltipTriggerMode.tap,
                        //       child: Row(children: [
                        //         FittedBox(
                        //             fit: BoxFit.fitHeight,
                        //             child: Text(
                        //               widget.data.rank.oneDigitForRankString,
                        //               style: TextStyle(
                        //                   color: Theme.of(context)
                        //                       .textTheme
                        //                       .bodyText2
                        //                       .color),
                        //             )),
                        //         Padding(
                        //             padding: const EdgeInsets.only(left: 3.0),
                        //             child: FittedBox(
                        //                 fit: BoxFit.fitHeight,
                        //                 child: Center(
                        //                     child: LineIcon(LineIcons.star)))),
                        //       ])),
                        // ),
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
    return SliverPadding(
      padding: EdgeInsets.only(top: 50),
      sliver: MultiSliver(
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
                    padding: const EdgeInsets.only(top: 20.0),
                    child: BouncingWidget(
                      duration: Duration(milliseconds: 300),
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'Satıcılardan ürün hakkında bilgi al',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.outline),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: BouncingWidget(
                      duration: Duration(milliseconds: 300),
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'Daha fazla bilgi almak için ürün adresine git',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.outline),
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
      ),
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
    return SliverPadding(
      padding: EdgeInsets.only(top: 50),
      sliver: MultiSliver(
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
          SliverToBoxAdapter(
            child: SizedBox(
              height: context.height,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductSuppliers(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 50),
      sliver: MultiSliver(
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
          SliverToBoxAdapter(
            child: SizedBox(
              height: context.height,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentMethods(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 50),
      sliver: MultiSliver(
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
          SliverToBoxAdapter(
            child: SizedBox(
              height: context.height,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCombinationSuggestion(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 50),
      sliver: MultiSliver(
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
          SliverToBoxAdapter(
            child: SizedBox(
              height: context.height,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInterestedSuggestion(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 50),
      sliver: MultiSliver(
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
          SliverToBoxAdapter(
            child: SizedBox(
              height: context.height,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomController(BuildContext context) {
    return Consumer<MyListsProvider>(builder: (context, provider, _) {
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
                  Expanded(
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Tooltip(
                            message: languageConverter(context, "share"),
                            triggerMode: TooltipTriggerMode.longPress,
                            child: IconButton(
                              icon: Pulse(
                                key: UniqueKey(),
                                animate: false,
                                manualTrigger: true,
                                controller: (c) {
                                  if (provider.constainsLike(widget.data)) {
                                    c.forward().whenComplete(() => c.reset());
                                  }
                                },
                                child: Icon(
                                  LineIcons.share,
                                  color: widget
                                      .palette.dominantColor.bodyTextColor
                                      .withAlpha(255),
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Tooltip(
                            message: languageConverter(context, "like"),
                            triggerMode: TooltipTriggerMode.longPress,
                            child: IconButton(
                              icon: Pulse(
                                key: UniqueKey(),
                                animate: false,
                                manualTrigger: true,
                                controller: (c) {
                                  if (provider.constainsLike(widget.data)) {
                                    c.forward().whenComplete(() => c.reset());
                                  }
                                },
                                child: Icon(
                                  LineIcons.heart,
                                  color: provider.constainsLike(widget.data)
                                      ? AppColors.red.shade300
                                      : widget
                                          .palette.dominantColor.bodyTextColor
                                          .withAlpha(255),
                                ),
                              ),
                              onPressed: () {
                                if (provider.constainsLike(widget.data)) {
                                  provider.removeLike(widget.data);
                                } else {
                                  provider.addLike(widget.data);
                                }
                              },
                            ),
                          ),
                          Tooltip(
                            message: languageConverter(context, "bookmark"),
                            triggerMode: TooltipTriggerMode.longPress,
                            child: IconButton(
                              icon: Bounce(
                                key: UniqueKey(),
                                from: 30,
                                manualTrigger: true,
                                animate: false,
                                controller: (p0) {
                                  if (provider.containsItem(widget.data)) {
                                    p0.forward().whenComplete(() {
                                      p0.reset();
                                    });
                                  }
                                },
                                child: Icon(
                                  LineIcons.bookmark,
                                  color: provider.containsItem(widget.data)
                                      ? AppColors.orange.shade300
                                      : widget
                                          .palette.dominantColor.bodyTextColor
                                          .withAlpha(255),
                                ),
                              ),
                              onPressed: () {
                                showFlexibleBookmarkSheet(context, widget.data);
                              },
                            ),
                          ),
                          Tooltip(
                            message: languageConverter(context, "basket"),
                            triggerMode: TooltipTriggerMode.longPress,
                            child: IconButton(
                              icon: Roulette(
                                key: UniqueKey(),
                                spins: 1,
                                animate: false,
                                manualTrigger: true,
                                controller: (c) {
                                  if (provider.containsOrder(widget.data)) {
                                    c.forward().whenComplete(() => c.reset());
                                  }
                                },
                                child: Icon(
                                  LineIcons.shoppingBag,
                                  color: provider.containsOrder(widget.data)
                                      ? AppColors.blue.shade200
                                      : widget
                                          .palette.dominantColor.bodyTextColor
                                          .withAlpha(255),
                                ),
                              ),
                              onPressed: () {
                                if (provider.containsOrder(widget.data)) {
                                  provider.removeOrder(widget.data);
                                } else {
                                  provider
                                      .addOrder(widget.data)
                                      .whenComplete(() {
                                    Timer(Duration(milliseconds: 1000), () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .tertiaryContainer,
                                        content: const Text('Sepete eklendi'),
                                        action: SnackBarAction(
                                            label: 'Sepete Git',
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const BasketPage(),
                                                  ));
                                            }),
                                      ));
                                    });
                                  });
                                }
                              },
                            ),
                          ),
                          Tooltip(
                            message: languageConverter(context, "gift"),
                            triggerMode: TooltipTriggerMode.longPress,
                            child: IconButton(
                              icon: Roulette(
                                key: UniqueKey(),
                                spins: 1,
                                animate: false,
                                manualTrigger: true,
                                controller: (c) {
                                  if (provider.containsOrder(widget.data)) {
                                    c.forward().whenComplete(() => c.reset());
                                  }
                                },
                                child: Icon(
                                  LineIcons.gift,
                                  color: provider.containsOrder(widget.data)
                                      ? AppColors.blue.shade200
                                      : widget
                                          .palette.dominantColor.bodyTextColor
                                          .withAlpha(255),
                                ),
                              ),
                              onPressed: () {
                                if (provider.containsOrder(widget.data)) {
                                  provider.removeOrder(widget.data);
                                } else {
                                  provider
                                      .addOrder(widget.data)
                                      .whenComplete(() {
                                    Timer(Duration(milliseconds: 1000), () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .tertiaryContainer,
                                        content: const Text('Sepete eklendi'),
                                        action: SnackBarAction(
                                            label: 'Sepete Git',
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const BasketPage(),
                                                  ));
                                            }),
                                      ));
                                    });
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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
    });
  }

  void backToTop() {
    _customScrollViewController.animateTo(
      0,
      duration: Duration(
          milliseconds:
              _customScrollViewController.position.pixels.toInt() ~/ 2),
      curve: Curves.easeOutCirc,
    );
  }
}
