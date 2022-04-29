import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/curves.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FlowListProductsView extends StatefulWidget {
  final FlowEntity data;
  const FlowListProductsView({Key? key, required this.data}) : super(key: key);

  @override
  State<FlowListProductsView> createState() => _FlowListProductsViewState();
}

class _FlowListProductsViewState extends State<FlowListProductsView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;
  late AnimationController? _bellAnimationController;

  int pageIndex = 0;
  bool hasSubscribe = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) => setState(() {
                pageIndex = index;
              }),
              pageSnapping: true,
              itemCount: widget.data.targetProducts!.length,
              itemBuilder: (context, index) {
                return ProductViewBody(
                    data: widget.data.targetProducts![index], index: index);
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: SizedBox(
                  height: 40,
                  width: context.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BouncingWidget(
                        onPressed: () => Navigator.pop(context),
                        child: const Center(
                          child: FaIcon(
                            LineIcons.arrowLeft,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 40,
                              minHeight: 40,
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!),
                                      borderRadius: appRadius(context)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Center(
                                      child: Marquee(
                                        text: widget.data.title!.toUpperCase(),
                                        numberOfRounds: 3,
                                        scrollAxis: Axis.horizontal,
                                        fadingEdgeStartFraction: 0.02,
                                        fadingEdgeEndFraction: 0.03,
                                        showFadingOnlyWhenScrolling: true,
                                        velocity: 30,
                                        decelerationDuration:
                                            const Duration(seconds: 3),
                                        startAfter: const Duration(seconds: 1),
                                        startPadding: 20,
                                        blankSpace: context.width * 0.5,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: BouncingWidget(
                                    onPressed: () {
                                      setState(() {
                                        hasSubscribe = !hasSubscribe;
                                        if (hasSubscribe) {
                                          _bellAnimationController
                                              ?.forward()
                                              .whenComplete(() {
                                            _bellAnimationController?.reset();
                                          });
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: appRadius(context),
                                          color: hasSubscribe
                                              ? AppColors.red
                                              : Theme.of(context).iconTheme.color,
                                        ),
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            maxHeight: 40,
                                            minHeight: 40,
                                          ),
                                          child: FittedBox(
                                            alignment: Alignment.center,
                                            child: Swing(
                                              child: Icon(
                                                FontAwesomeIcons.solidBell,
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                              ),
                                              animate: false,
                                              manualTrigger: true,
                                              controller: (va) {
                                                _bellAnimationController = va;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductViewBody extends StatefulWidget {
  final Product data;
  final int index;
  const ProductViewBody({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<ProductViewBody> createState() => _ProductViewBodyState();
}

class _ProductViewBodyState extends State<ProductViewBody>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController? _heartAnimationController;
  late AnimationController? _bookmarkAnimationController;
  late AnimationController? _basketAnimationController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.75);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeChanger>(context, listen: false).isDark();
    return Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.only(top: 110.0, bottom: 50),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SizedBox(
                    width: context.width,
                    height: context.width * 0.5,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.data.photosUrl!.length,
                      itemBuilder: (context, index) {
                        return ClipRect(
                          child: Image.network(
                            widget.data.photosUrl![index],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingIndicator(
                                    context, child, loadingProgress),
                          ),
                        );
                      },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: widget.data.photosUrl!.length,
                    onDotClicked: (index) => _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 700),
                      curve: const SpringCurve(),
                    ),
                    effect: SwapEffect(
                        activeDotColor: AppColors.red,
                        dotColor: Theme.of(context).iconTheme.color!),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.title! + '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 23, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            widget.data.description!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              widget.data.discountRate == null
                                  ? const SizedBox()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Text(
                                        widget.data.price!.twoDigitForMoney,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              fontSize: 19,
                                              backgroundColor:
                                                  AppColors.red.shade500,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                      ),
                                    ),
                              Text(
                                discountedCalculate(widget.data.price!,
                                        widget.data.discountRate)
                                    .twoDigitForMoney,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      fontSize: 19,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 25,
                                    maxHeight: 25,
                                  ),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RatingBar.builder(
                                          allowHalfRating: true,
                                          onRatingUpdate: (v) {},
                                          ignoreGestures: true,
                                          unratedColor: isDark
                                              ? AppColors.black.shade200
                                              : AppColors.grey.shade300,
                                          initialRating:
                                              widget.data.rank!.rankRound,
                                          itemSize: 20,
                                          itemBuilder: (context, index) {
                                            return FaIcon(
                                              FontAwesomeIcons.solidStar,
                                              color: isDark
                                                  ? AppColors.orange.shade500
                                                  : AppColors.orange.shade500,
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              minHeight: 25,
                                              maxHeight: 25,
                                            ),
                                            child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                widget.data.rank!
                                                        .oneDigitForRankString +
                                                    '',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 25,
                                    maxHeight: 25,
                                  ),
                                  child: FittedBox(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Tooltip(
                                          message:
                                              'Ürünü kaç kişi değerlendirdi?',
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5.0, left: 5.0),
                                                child: ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                    minHeight: 20,
                                                    maxHeight: 20,
                                                    maxWidth: 20,
                                                    minWidth: 20,
                                                  ),
                                                  child: const FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: Center(
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidCommentDots,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 25,
                                                  maxHeight: 25,
                                                ),
                                                child: FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: Text(
                                                    NumberFormat.compact(
                                                            locale: 'en_US')
                                                        .format(widget.data
                                                            .commentCount!),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Tooltip(
                                            message:
                                                'Ürünü kaç kişi satın aldı?',
                                            triggerMode: TooltipTriggerMode.tap,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5.0),
                                                  child: ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                      minHeight: 20,
                                                      maxHeight: 20,
                                                      maxWidth: 20,
                                                      minWidth: 20,
                                                    ),
                                                    child: const FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Center(
                                                        child: FaIcon(
                                                          FontAwesomeIcons.box,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                    minHeight: 25,
                                                    maxHeight: 25,
                                                  ),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: Text(
                                                      NumberFormat.compact(
                                                              locale: 'en_US')
                                                          .format(widget.data
                                                              .purchasesCount!),
                                                    ),
                                                  ),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                child: FittedBox(
                                  child: Text(
                                    'Ürün detayına git',
                                    style: TextStyle(
                                      color: Theme.of(context).iconTheme.color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                      const Size.fromHeight(40)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: appRadius(context),
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!,
                                          width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: BouncingWidget(
                                onPressed: () {},
                                child: const SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Center(
                                      child: FaIcon(
                                        LineIcons.share,
                                        size: 40,
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: BouncingWidget(
                                onPressed: () {
                                  if (_bookmarkAnimationController != null) {
                                    setState(() {
                                      widget.data.isAddedBookmark =
                                          !widget.data.isAddedBookmark;
                                      if (widget.data.isAddedBookmark) {
                                        if (!_bookmarkAnimationController!
                                            .isAnimating) {
                                          WidgetsBinding.instance!
                                              .addPostFrameCallback(
                                                  (timeStamp) {
                                            _bookmarkAnimationController!
                                                .forward()
                                                .whenComplete(() {
                                              _bookmarkAnimationController!
                                                  .reset();
                                            });
                                          });
                                        }
                                      }
                                    });
                                  }
                                },
                                child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Center(
                                      child: Bounce(
                                        child: FaIcon(
                                          LineIcons.bookmark,
                                          size: 40,
                                          color: widget.data.isAddedBookmark
                                              ? AppColors.orange.shade500
                                              : Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                        ),
                                        animate: false,
                                        manualTrigger: true,
                                        controller: (c) {
                                          _bookmarkAnimationController = c;
                                        },
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: BouncingWidget(
                                onPressed: () {
                                  if (_heartAnimationController != null) {
                                    setState(() {
                                      widget.data.isLiked =
                                          !widget.data.isLiked;
                                      if (widget.data.isLiked) {
                                        if (!_heartAnimationController!
                                            .isAnimating) {
                                          WidgetsBinding.instance!
                                              .addPostFrameCallback(
                                                  (timeStamp) {
                                            _heartAnimationController!
                                                .forward()
                                                .whenComplete(() {
                                              _heartAnimationController!
                                                  .reset();
                                            });
                                          });
                                        }
                                      }
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: Pulse(
                                      key: UniqueKey(),
                                      child: FaIcon(
                                        LineIcons.heart,
                                        size: 40,
                                        color: widget.data.isLiked
                                            ? AppColors.red.shade400
                                            : Theme.of(context).iconTheme.color,
                                      ),
                                      animate: false,
                                      manualTrigger: true,
                                      controller: (c) {
                                        _heartAnimationController = c;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: BouncingWidget(
                                onPressed: () {
                                  if (_basketAnimationController != null) {
                                    setState(() {
                                      widget.data.isAddedCart =
                                          !widget.data.isAddedCart;
                                      if (widget.data.isAddedCart) {
                                        if (!_basketAnimationController!
                                            .isAnimating) {
                                          WidgetsBinding.instance!
                                              .addPostFrameCallback(
                                                  (timeStamp) {
                                            _basketAnimationController!
                                                .forward()
                                                .whenComplete(() {
                                              _basketAnimationController!
                                                  .reset();
                                            });
                                          });
                                        }
                                      }
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: Roulette(
                                      child: FaIcon(
                                        LineIcons.shoppingBag,
                                        size: 40,
                                        color: widget.data.isAddedCart
                                            ? AppColors.blue.shade200
                                            : Theme.of(context).iconTheme.color,
                                      ),
                                      animate: false,
                                      manualTrigger: true,
                                      controller: (c) {
                                        _basketAnimationController = c;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
