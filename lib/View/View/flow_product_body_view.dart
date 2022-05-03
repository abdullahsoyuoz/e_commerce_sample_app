import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/controllers/icon_controller.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Controller/Picker/icon_picker.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/Dummy/mylists.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Page/User/Product/product_detail.dart';
import 'package:sepet_demo/View/Clipper/star_rank_clipper.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/curves.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/View/Sheets/bookmark_sheet.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


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
  late ScrollController _scrollController;
  late AnimationController? _heartAnimationController;
  late AnimationController? _bookmarkAnimationController;
  late AnimationController? _basketAnimationController;
  late AnimationController _rankAnimationController;
  late AnimationController _rankSolidAnimationController;
  late final IconController _iconController;

  @override
  void initState() {
    _rankAnimationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 1000) * widget.data.rank!,
    );
    _rankSolidAnimationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 1000) * widget.data.rank!,
    );
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    super.initState();
    _iconController = IconController();
    _scrollController = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _rankAnimationController.animateTo(widget.data.rank! / 5);
      _rankSolidAnimationController.animateTo(1);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _rankAnimationController.dispose();
    _rankSolidAnimationController.dispose();
    _scrollController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        key: UniqueKey(),
        padding: const EdgeInsets.only(top: 110.0, bottom: 50),
        child: Column(children: [
          Column(
            children: [
              SizedBox(
                width: context.width,
                height: context.width * 0.8,
                child: PageView.builder(
                  controller: _pageController,
                  physics: const PageScrollPhysics(
                    parent: BouncingScrollPhysics()
                  ),
                  itemCount: widget.data.photosUrl!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(lineThickness()),
                      child: Image.network(
                        widget.data.photosUrl![index],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingIndicator(context, child, loadingProgress),
                      ),
                    );
                  },
                ),
              ),
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
                      padding:
                          const EdgeInsets.only(top: 5.0, left: 20, right: 20),
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
                                            fontSize: 23,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      widget.data.description!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FittedBox(
                                              child: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
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
                                                        triggerMode:
                                                            TooltipTriggerMode
                                                                .tap,
                                                        child: Row(children: [
                                                          FittedBox(
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                              child: Text(NumberFormat
                                                                      .compact(
                                                                          locale:
                                                                              'en_US')
                                                                  .format(widget
                                                                      .data
                                                                      .purchasesCount!))),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child: FittedBox(
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  child: Center(
                                                                      child: LineIcon(
                                                                          LineIcons
                                                                              .box)))),
                                                        ])),
                                                    const VerticalDivider(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Tooltip(
                                                          message:
                                                              'Ürünü ${widget.data.commentCount} kişi değerlendirdi.',
                                                          triggerMode:
                                                              TooltipTriggerMode
                                                                  .tap,
                                                          child: Row(children: [
                                                            FittedBox(
                                                                fit: BoxFit
                                                                    .fitHeight,
                                                                child: Text(NumberFormat
                                                                        .compact(
                                                                            locale:
                                                                                'en_US')
                                                                    .format(widget
                                                                        .data
                                                                        .commentCount!))),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: FittedBox(
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                    child: Center(
                                                                        child: LineIcon(
                                                                            LineIcons.comment)))),
                                                          ])),
                                                    ),
                                                    const VerticalDivider(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Tooltip(
                                                          message:
                                                              'Ürünün ortalama puanı',
                                                          triggerMode:
                                                              TooltipTriggerMode
                                                                  .tap,
                                                          child: Row(children: [
                                                            FittedBox(
                                                                fit: BoxFit
                                                                    .fitHeight,
                                                                child: Text(
                                                                  widget
                                                                      .data
                                                                      .rank!
                                                                      .oneDigitForRankString,
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText2!
                                                                          .color),
                                                                )),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child:
                                                                    FittedBox(
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  child:
                                                                      FittedBox(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            ClipPath(
                                                                              clipper: StarRankPainter(
                                                                                rank: widget.data.rank!,
                                                                                animationController: _rankSolidAnimationController,
                                                                              ),
                                                                              child: Center(
                                                                                child: Row(
                                                                                  children: List.generate(
                                                                                    5,
                                                                                    (index) => LineIcon(
                                                                                      LineIcons.starAlt,
                                                                                      color: Theme.of(context).colorScheme.primaryContainer,
                                                                                    ),
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
                                                                                animationController: _rankAnimationController,
                                                                              ),
                                                                              child: Center(
                                                                                child: Row(
                                                                                  children: List.generate(
                                                                                    5,
                                                                                    (index) => LineIcon(
                                                                                      LineIcons.starAlt,
                                                                                      color: AppColors.orange.shade500,
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
                                                                )),
                                                          ])),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ])),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        widget.data.discountRate == null
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5.0),
                                                child: Text(
                                                  widget.data.price!
                                                      .twoDigitForMoney,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                        fontSize: 19,
                                                        backgroundColor:
                                                            AppColors
                                                                .red.shade500,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                ),
                                              ),
                                        Text(
                                          discountedCalculate(
                                                  widget.data.price!,
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
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () => Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailPage(
                                                          data: widget.data),
                                                )),
                                            child: FittedBox(
                                              child: Text(
                                                'Ürün detayına git',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: BouncingWidget(
                                                onPressed: () {},
                                                child: SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child: Center(
                                                        child: LineIcon(
                                                            LineIcons
                                                                .share))))),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: BouncingWidget(
                                              onPressed: () {
                                                if (!widget
                                                    .data.isAddedBookmark) {
                                                  showFlexibleBookmarkSheet(
                                                          context)
                                                      .whenComplete(() {
                                                    Timer(
                                                        const Duration(
                                                            milliseconds: 600),
                                                        () {
                                                      if (_bookmarkAnimationController !=
                                                          null) {
                                                        setState(() {
                                                          widget.data
                                                                  .isAddedBookmark =
                                                              !widget.data
                                                                  .isAddedBookmark;
                                                          if (widget.data
                                                              .isAddedBookmark) {
                                                            if (!_bookmarkAnimationController!
                                                                .isAnimating) {
                                                              WidgetsBinding
                                                                  .instance!
                                                                  .addPostFrameCallback(
                                                                      (timeStamp) {
                                                                _bookmarkAnimationController!
                                                                    .forward()
                                                                    .whenComplete(
                                                                        () {
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
                                                      widget.data
                                                              .isAddedBookmark =
                                                          !widget.data
                                                              .isAddedBookmark;
                                                      if (widget.data
                                                          .isAddedBookmark) {
                                                        if (!_bookmarkAnimationController!
                                                            .isAnimating) {
                                                          WidgetsBinding
                                                              .instance!
                                                              .addPostFrameCallback(
                                                                  (timeStamp) {
                                                            _bookmarkAnimationController!
                                                                .forward()
                                                                .whenComplete(
                                                                    () {
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
                                              child: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: Center(
                                                      child: Bounce(
                                                          child: LineIcon(
                                                            LineIcons.bookmark,
                                                            color: widget.data
                                                                    .isAddedBookmark
                                                                ? AppColors
                                                                    .orange
                                                                    .shade500
                                                                : Theme.of(
                                                                        context)
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
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: BouncingWidget(
                                                onPressed: () {
                                                  if (_heartAnimationController !=
                                                      null) {
                                                    setState(() {
                                                      widget.data.isLiked =
                                                          !widget.data.isLiked;
                                                      if (widget.data.isLiked) {
                                                        if (!_heartAnimationController!
                                                            .isAnimating) {
                                                          WidgetsBinding
                                                              .instance!
                                                              .addPostFrameCallback(
                                                                  (timeStamp) {
                                                            _heartAnimationController!
                                                                .forward()
                                                                .whenComplete(
                                                                    () {
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
                                                            child: LineIcon(
                                                              LineIcons.heart,
                                                              color: widget.data
                                                                      .isLiked
                                                                  ? AppColors
                                                                      .red
                                                                      .shade400
                                                                  : Theme.of(
                                                                          context)
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
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: BouncingWidget(
                                                onPressed: () {
                                                  if (_basketAnimationController !=
                                                      null) {
                                                    setState(() {
                                                      widget.data.isAddedCart =
                                                          !widget
                                                              .data.isAddedCart;
                                                      if (widget
                                                          .data.isAddedCart) {
                                                        if (!_basketAnimationController!
                                                            .isAnimating) {
                                                          WidgetsBinding
                                                              .instance!
                                                              .addPostFrameCallback(
                                                                  (timeStamp) {
                                                            _basketAnimationController!
                                                                .forward()
                                                                .whenComplete(
                                                                    () {
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
                                                            child: LineIcon(
                                                                LineIcons
                                                                    .shoppingBag,
                                                                color: widget
                                                                        .data
                                                                        .isAddedCart
                                                                    ? AppColors
                                                                        .blue
                                                                        .shade400
                                                                    : Theme.of(
                                                                            context)
                                                                        .iconTheme
                                                                        .color),
                                                            animate: false,
                                                            manualTrigger: true,
                                                            controller: (c) {
                                                              _basketAnimationController =
                                                                  c;
                                                            })))))
                                      ])
                                ])
                          ]))))
        ]));
  }

  Future<void> showMyListSheet() async {
    showCupertinoModalPopup(
        context: context,
        barrierColor: Colors.black.withOpacity(.75),
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Material(
              shape: RoundedRectangleBorder(borderRadius: appRadius(context)),
              // elevation: 0,
              color: Colors.transparent,
              child: Container(
                height: context.height * 0.7,
                width: context.width * 0.9,
                margin: const EdgeInsets.all(20),
                // padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: appRadius(context),
                ),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top:
                              Radius.circular(appRadius(context).bottomLeft.x)),
                      color: Theme.of(context)
                          .appBarTheme
                          .backgroundColor!
                          .withOpacity(1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Listelerim',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 17),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => showNewListSheet(),
                                  icon: LineIcon(LineIcons.plus)),
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: LineIcon(LineIcons.times))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: myLists.length,
                      itemBuilder: (context, index) {
                        var e = myLists[index];
                        return ListTile(
                          leading: e.iconData != null
                              ? LineIcon(e.iconData!)
                              : const SizedBox(),
                          trailing: Text(e.products!.length.toString()),
                          title: Text(e.title!),
                          onTap: () {},
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  )
                ]),
              ),
            );
          });
        });
  }

  Future<void> showNewListSheet() async {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: Container(
              height: context.height * 0.7,
              width: context.width * 0.9,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: appRadius(context),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top:
                              Radius.circular(appRadius(context).bottomLeft.x)),
                      color: Theme.of(context)
                          .appBarTheme
                          .backgroundColor!
                          .withOpacity(1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Liste oluştur',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 17),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: LineIcon(LineIcons.times))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(hintText: 'Liste adı'),
                  ),
                  IconButton(
                      onPressed: () {
                        iconPicker(context);
                      },
                      icon: LineIcon(LineIcons.icons))
                ],
              ),
            ),
          );
        });
  }
}