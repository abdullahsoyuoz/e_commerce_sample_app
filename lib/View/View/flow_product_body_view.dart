import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Page/User/Product/product_detail.dart';
import 'package:sepet_demo/View/Clipper/star_rank_clipper.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/View/Sheets/bookmark_sheet.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

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
  late AnimationController? _heartAnimationController;
  late AnimationController? _bookmarkAnimationController;
  late AnimationController? _basketAnimationController;
  late AnimationController _rankAnimationController;

  @override
  void initState() {
    _rankAnimationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 1000) * widget.data.rank!,
    );

    super.initState();
  }

  @override
  void dispose() {
    _rankAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _rankAnimationController.animateTo(widget.data.rank! / 5);
    });
    return ClipRRect(
      borderRadius: appRadius(context),
      child: Column(
        key: UniqueKey(),
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: Theme.of(context).iconTheme.color!),
                Image.network(
                  widget.data.photosUrl![0],
                  width: context.width,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingIndicator(context, child, loadingProgress),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 3,
              child: Padding(
                  padding: const EdgeInsets.all(10),
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
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  widget.data.description!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: FittedBox(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minHeight: 20,
                                      maxHeight: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Tooltip(
                                            message:
                                                'Ürünü ${widget.data.purchasesCount} kişi satın aldı.',
                                            triggerMode: TooltipTriggerMode.tap,
                                            child: Row(children: [
                                              FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: Text(NumberFormat
                                                          .compact(
                                                              locale: 'en_US')
                                                      .format(widget.data
                                                          .purchasesCount!))),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3.0),
                                                  child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Center(
                                                          child: LineIcon(
                                                              LineIcons.box)))),
                                            ])),
                                        const VerticalDivider(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3.0),
                                          child: Tooltip(
                                              message:
                                                  'Ürünü ${widget.data.commentCount} kişi değerlendirdi.',
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: Row(children: [
                                                FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: Text(NumberFormat
                                                            .compact(
                                                                locale: 'en_US')
                                                        .format(widget.data
                                                            .commentCount!))),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                    child: FittedBox(
                                                        fit: BoxFit.fitHeight,
                                                        child: Center(
                                                            child: LineIcon(
                                                                LineIcons
                                                                    .comment)))),
                                              ])),
                                        ),
                                        const VerticalDivider(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3.0),
                                          child: Tooltip(
                                              message: 'Ürünün ortalama puanı',
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: Row(children: [
                                                FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: Text(
                                                      widget.data.rank!
                                                          .oneDigitForRankString,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .color),
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                    child: FittedBox(
                                                        fit: BoxFit.fitHeight,
                                                        child: Center(
                                                            child: LineIcon(
                                                                LineIcons
                                                                    .star)))),
                                              ])),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 25,
                                    maxHeight: 25,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    alignment: Alignment.centerLeft,
                                    child: Stack(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipPath(
                                              clipper: StarRankPainter(
                                                rank: widget.data.rank!,
                                                animationController:
                                                    _rankAnimationController,
                                              ),
                                              child: Center(
                                                child: Row(
                                                  children: List.generate(
                                                    5,
                                                    (index) => LineIcon(
                                                      LineIcons.starAlt,
                                                      color: AppColors
                                                          .orange.shade500,
                                                    ),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.data.discountRate == null
                                        ? const SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text(
                                              widget
                                                  .data.price!.twoDigitForMoney,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    fontSize: 17,
                                                    backgroundColor:
                                                        AppColors.red.shade500,
                                                    decoration: TextDecoration
                                                        .lineThrough,
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
                                            fontSize: 17,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => ProductDetailPage(
                                            data: widget.data),
                                      )),
                                  child: FittedBox(
                                    child: Text(
                                      'Ürüne git',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: IconButton(
                                    onPressed: () {
                                      if (!widget.data.isAddedBookmark) {
                                        showFlexibleBookmarkSheet(
                                                context, widget.data)
                                            .whenComplete(() {
                                          Timer(
                                              const Duration(milliseconds: 600),
                                              () {
                                            if (_bookmarkAnimationController !=
                                                null) {
                                              setState(() {
                                                widget.data.isAddedBookmark =
                                                    !widget
                                                        .data.isAddedBookmark;
                                                if (widget
                                                    .data.isAddedBookmark) {
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
                                          });
                                        });
                                      } else {
                                        if (_bookmarkAnimationController !=
                                            null) {
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
                                      }
                                    },
                                    icon: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Center(
                                            child: Bounce(
                                                child: LineIcon(
                                                  LineIcons.bookmark,
                                                  color: widget
                                                          .data.isAddedBookmark
                                                      ? AppColors
                                                          .orange.shade500
                                                      : Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                                ),
                                                animate: false,
                                                manualTrigger: true,
                                                controller: (c) {
                                                  _bookmarkAnimationController =
                                                      c;
                                                })))),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: IconButton(
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
                                      icon: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Center(
                                              child: Pulse(
                                                  key: UniqueKey(),
                                                  child: LineIcon(
                                                    LineIcons.heart,
                                                    color: widget.data.isLiked
                                                        ? AppColors.red.shade400
                                                        : Theme.of(context)
                                                            .iconTheme
                                                            .color,
                                                  ),
                                                  animate: false,
                                                  manualTrigger: true,
                                                  controller: (c) {
                                                    _heartAnimationController =
                                                        c;
                                                  }))))),
                              Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: IconButton(
                                      onPressed: () {
                                        if (_basketAnimationController !=
                                            null) {
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
                                      icon: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Center(
                                              child: Roulette(
                                                  child: LineIcon(
                                                      LineIcons.shoppingBag,
                                                      color: widget
                                                              .data.isAddedCart
                                                          ? AppColors
                                                              .blue.shade400
                                                          : Theme.of(context)
                                                              .iconTheme
                                                              .color),
                                                  animate: false,
                                                  manualTrigger: true,
                                                  controller: (c) {
                                                    _basketAnimationController =
                                                        c;
                                                  })))))
                            ])
                      ])))
        ],
      ),
    );
  }
}
