import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/Provider/mylist_provider.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Page/User/Order/basket.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/View/Sheets/bookmark_sheet.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

class ProductViewBody extends StatefulWidget {
  final Product data;
  final int index;
  const ProductViewBody({Key key, this.data, this.index}) : super(key: key);

  @override
  State<ProductViewBody> createState() => _ProductViewBodyState();
}

class _ProductViewBodyState extends State<ProductViewBody>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyListsProvider>(builder: (context, provider, _) {
      return SlideInDown(
        child: ClipRRect(
          borderRadius: appRadius(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                key: UniqueKey(),
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ColoredBox(color: Theme.of(context).iconTheme.color),
                        Image.network(
                          widget.data.photosUrl[0],
                          width: context.width,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingIndicator(context, child, loadingProgress),
                        ),
                        !widget.data.isNew
                            ? const SizedBox()
                            : Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SlideInDown(
                                    // infinite: true,
                                    duration: const Duration(seconds: 1),
                                    // spins: 1,
                                    child: Card(
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.red,
                                        foregroundColor: Colors.white,
                                        child: Text(
                                            languageConverter(context, "new")),
                                      ),
                                    ),
                                  ),
                                ),
                              )
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
                                Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.data.title + '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            widget.data.description,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontStyle:
                                                        FontStyle.normal),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
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
                                                          languageConverter(
                                                              context,
                                                              "buyCount"),
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
                                                                    .purchasesCount))),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 3.0),
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
                                                            left: 3.0),
                                                    child: Tooltip(
                                                        message:
                                                            languageConverter(
                                                                context,
                                                                "reviewsCount"),
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
                                                                      .commentCount))),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          3.0),
                                                              child: FittedBox(
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  child: Center(
                                                                      child: LineIcon(
                                                                          LineIcons
                                                                              .comment)))),
                                                        ])),
                                                  ),
                                                  const VerticalDivider(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                    child: Tooltip(
                                                        message:
                                                            languageConverter(
                                                                context,
                                                                "averagePoint"),
                                                        triggerMode:
                                                            TooltipTriggerMode
                                                                .tap,
                                                        child: Row(children: [
                                                          FittedBox(
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                              child: Text(
                                                                widget.data.rank
                                                                    .oneDigitForRankString,
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2
                                                                        .color),
                                                              )),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          3.0),
                                                              child: FittedBox(
                                                                  fit: BoxFit
                                                                      .fitHeight,
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
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              widget.data.discountRate == null
                                                  ? const SizedBox()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5.0),
                                                      child: Text(
                                                        widget.data.price
                                                            .twoDigitForMoney,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2
                                                            .copyWith(
                                                              fontSize: 17,
                                                              backgroundColor:
                                                                  AppColors.red
                                                                      .shade300,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                      ),
                                                    ),
                                              Text(
                                                discountedCalculate(
                                                        widget.data.price,
                                                        widget
                                                            .data.discountRate)
                                                    .twoDigitForMoney,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(
                                                      fontSize: 17,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: AbsorbPointer(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: FittedBox(
                                              child: Text(
                                                languageConverter(
                                                    context, "goProduct"),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            showFlexibleBookmarkSheet(
                                                context, widget.data);
                                          },
                                          icon: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Bounce(
                                                from: 30,
                                                manualTrigger: true,
                                                animate: false,
                                                controller: (p0) {
                                                  if (provider.containsItem(
                                                      widget.data)) {
                                                    p0
                                                        .forward()
                                                        .whenComplete(() {
                                                      p0.reset();
                                                    });
                                                  }
                                                },
                                                child: Center(
                                                    child: LineIcon(
                                                  LineIcons.bookmark,
                                                  color: provider.containsItem(
                                                          widget.data)
                                                      ? AppColors
                                                          .orange.shade300
                                                      : Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                                )),
                                              ))),
                                      IconButton(
                                          onPressed: () {
                                            if (provider
                                                .constainsLike(widget.data)) {
                                              provider.removeLike(widget.data);
                                            } else {
                                              provider.addLike(widget.data);
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
                                                        color: provider
                                                                .constainsLike(
                                                                    widget.data)
                                                            ? AppColors
                                                                .red.shade300
                                                            : Theme.of(context)
                                                                .iconTheme
                                                                .color,
                                                      ),
                                                      animate: false,
                                                      manualTrigger: true,
                                                      controller: (c) {
                                                        if (provider
                                                            .constainsLike(
                                                                widget.data)) {
                                                          c
                                                              .forward()
                                                              .whenComplete(
                                                                  () => c
                                                                      .reset());
                                                        }
                                                      })))),
                                      IconButton(
                                          onPressed: () {
                                            if (provider
                                                .containsOrder(widget.data)) {
                                              provider.removeOrder(widget.data);
                                            } else {
                                              provider
                                                  .addOrder(widget.data)
                                                  .whenComplete(() {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: const Text(
                                                      'Sepete eklendi'),
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
                                            }
                                          },
                                          icon: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Center(
                                                  child: Roulette(
                                                      spins: 1,
                                                      animate: false,
                                                      manualTrigger: true,
                                                      child: LineIcon(
                                                          LineIcons.shoppingBag,
                                                          color: provider
                                                                  .containsOrder(
                                                                      widget
                                                                          .data)
                                                              ? AppColors
                                                                  .blue.shade200
                                                              : Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color),
                                                      controller: (c) {
                                                        if (provider
                                                            .containsOrder(
                                                                widget.data)) {
                                                          c
                                                              .forward()
                                                              .whenComplete(
                                                                  () => c
                                                                      .reset());
                                                        }
                                                      }))))
                                    ])
                              ])))
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
