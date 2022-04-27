// ignore_for_file: must_be_immutable
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FlowListProductsView extends StatefulWidget {
  late FlowEntity data;
  FlowListProductsView({Key? key, required this.data}) : super(key: key);

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
                        child: Container(
                            width: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: appRadius(context),
                              color: Theme.of(context).iconTheme.color,
                            ),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 40,
                                minHeight: 20,
                              ),
                              child: FittedBox(
                                alignment: Alignment.center,
                                child: FaIcon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 40,
                              minHeight: 40,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7.0, vertical: 0),
                              child: Center(
                                child: Marquee(
                                  text: widget.data.title!.toUpperCase(),
                                  numberOfRounds: 1,
                                  scrollAxis: Axis.horizontal,
                                  fadingEdgeStartFraction: 0.03,
                                  fadingEdgeEndFraction: 0.03,
                                  showFadingOnlyWhenScrolling: true,
                                  velocity: 30,
                                  blankSpace: 100,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      BouncingWidget(
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
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: appRadius(context),
                            color: hasSubscribe
                                ? AppColors.red
                                : Theme.of(context).iconTheme.color,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 40,
                              minHeight: 20,
                            ),
                            child: FittedBox(
                              alignment: Alignment.center,
                              child: Swing(
                                child: Icon(
                                  FontAwesomeIcons.solidBell,
                                  color: Theme.of(context).backgroundColor,
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
  Product data;
  int index;
  ProductViewBody({Key? key, required this.data, required this.index})
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
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: UniqueKey(),
      padding:
          const EdgeInsets.only(top: 110.0, bottom: 50, left: 20, right: 20),
      child: Column(
        children: [
          Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).iconTheme.color,
                ),
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: context.width,
                      height: context.width * 0.5,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.data.photosUrl!.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.data.photosUrl![index],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingIndicator(
                                    context, child, loadingProgress),
                          );
                        },
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: widget.data.photosUrl!.length,
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
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              widget.data.discountRate == null
                                  ? const SizedBox()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Text(
                                        getPrice(widget.data.price!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              fontSize: 19,
                                              backgroundColor:
                                                  AppColors.red.shade300,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                      ),
                                    ),
                              Text(
                                getPrice(discountedCalculate(widget.data.price!,
                                    widget.data.discountRate)),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RatingBar.builder(
                                      allowHalfRating: true,
                                      onRatingUpdate: (v) {},
                                      ignoreGestures: true,
                                      initialRating: widget.data.rank!,
                                      itemSize: 20,
                                      itemBuilder: (context, index) {
                                        return FaIcon(
                                          FontAwesomeIcons.solidStar,
                                          color: Provider.of<ThemeChanger>(
                                                      context,
                                                      listen: false)
                                                  .isDark
                                              ? AppColors.orange.shade100
                                              : AppColors.orange.shade300,
                                        );
                                      },
                                    ),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minHeight: 25,
                                        maxHeight: 25,
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          widget.data.rank!.toStringAsFixed(1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: BouncingWidget(
                                  onPressed: () {},
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            minHeight: 20,
                                            maxHeight: 20,
                                            maxWidth: 20,
                                            minWidth: 20,
                                          ),
                                          child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.solidComment,
                                                color: Provider.of<
                                                                ThemeChanger>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? AppColors.blue.shade100
                                                    : AppColors.blue.shade200,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minHeight: 25,
                                          maxHeight: 25,
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            NumberFormat.compact(
                                                    locale: 'en_US')
                                                .format(
                                                    widget.data.commentCount!),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: BouncingWidget(
                                  onPressed: () {},
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
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
                                        constraints: const BoxConstraints(
                                          minHeight: 25,
                                          maxHeight: 25,
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            NumberFormat.compact(
                                                    locale: 'en_US')
                                                .format(widget.data.rankCount!),
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
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: BouncingWidget(
                                  onPressed: () {},
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          borderRadius: appRadius(context)),
                                      child: Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.shareNodes,
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: BouncingWidget(
                                  onPressed: () {
                                    if (_bookmarkAnimationController != null) {
                                      if (!widget.data.isAddedBookmark) {
                                        if (!_bookmarkAnimationController!
                                            .isAnimating) {
                                          widget.data.isAddedBookmark = true;
                                          _bookmarkAnimationController!
                                              .forward()
                                              .whenComplete(() {
                                            setState(() {});
                                            _bookmarkAnimationController!.reset();
                                          });
                                        }
                                      } else if (widget.data.isAddedBookmark) {
                                        widget.data.isAddedBookmark = false;
                                        setState(() {});
                                      }
                                    }
                                  },
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          borderRadius: appRadius(context)),
                                      child: Center(
                                        child: Bounce(
                                          child: FaIcon(
                                            FontAwesomeIcons.solidBookmark,
                                            color: widget.data.isAddedBookmark
                                                ? AppColors.orange
                                                : Theme.of(context)
                                                    .backgroundColor,
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
                                      if (!widget.data.isLiked) {
                                        if (!_heartAnimationController!
                                            .isAnimating) {
                                          widget.data.isLiked = true;
                                          _heartAnimationController!
                                              .forward()
                                              .whenComplete(() {
                                            setState(() {});
                                            _heartAnimationController!.reset();
                                          });
                                        }
                                      } else if (widget.data.isLiked) {
                                        widget.data.isLiked = false;
                                        setState(() {});
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        borderRadius: appRadius(context)),
                                    child: Center(
                                      child: Pulse(
                                        key: UniqueKey(),
                                        child: FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          color: widget.data.isLiked
                                              ? AppColors.red
                                              : Theme.of(context)
                                                  .backgroundColor,
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
                                      if (!widget.data.isAddedCart) {
                                        if (!_basketAnimationController!
                                            .isAnimating) {
                                          widget.data.isAddedCart = true;
                                          _basketAnimationController!
                                              .forward()
                                              .whenComplete(() {
                                            setState(() {});
                                            _basketAnimationController!.reset();
                                          });
                                        }
                                      } else if (widget.data.isAddedCart) {
                                        widget.data.isAddedCart = false;
                                        setState(() {});
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        borderRadius: appRadius(context)),
                                    child: Center(
                                      child: Roulette(
                                        child: FaIcon(
                                          FontAwesomeIcons.bagShopping,
                                          color: widget.data.isAddedCart
                                              ? AppColors.turquaz.shade100
                                              : Theme.of(context)
                                                  .backgroundColor,
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
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Ürünün detayına git',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
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
