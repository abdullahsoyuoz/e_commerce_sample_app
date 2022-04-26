// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FlowListProductsView extends StatefulWidget {
  late FlowEntity data;
  FlowListProductsView({Key? key, required this.data}) : super(key: key);

  @override
  State<FlowListProductsView> createState() => _FlowListProductsViewState();
}

class _FlowListProductsViewState extends State<FlowListProductsView> {
  late PageController _pageController;
  int pageIndex = 0;
  bool hasSubscribe = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    if (mounted) {
      _pageController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
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
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color,
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 40,
                                minHeight: 20,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7.0, vertical: 3.0),
                                child: Text(
                                  widget.data.title!.toUpperCase() + '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                        onPressed: () => setState(() {
                          hasSubscribe = !hasSubscribe;
                        }),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: hasSubscribe
                                ? AppColors.red
                                : Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 40,
                              minHeight: 20,
                            ),
                            child: FittedBox(
                                alignment: Alignment.center,
                                child: hasSubscribe
                                    ? const Icon(FontAwesomeIcons.solidBell)
                                    : const Text('TAKİP ET')),
                          ),
                        ),
                      )
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

class _ProductViewBodyState extends State<ProductViewBody> {
  late PageController _pageController;

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
      padding:
          const EdgeInsets.only(top: 110.0, bottom: 50, left: 20, right: 20),
      child: Column(
        children: [
          Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
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
                        dotColor: Theme.of(context).colorScheme.primaryContainer),
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
                                                FontAwesomeIcons.solidStar,
                                                color: Provider.of<
                                                                ThemeChanger>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? AppColors.orange.shade100
                                                    : AppColors.orange.shade300,
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
                                            widget.data.rank!
                                                .toStringAsFixed(1),
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
                                padding: const EdgeInsets.only(left: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child:
                                      const FaIcon(FontAwesomeIcons.shareNodes),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    widget.data.isAddedBookmark =
                                        !widget.data.isAddedBookmark;
                                    setState(() {});
                                  },
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .copyWith(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  !widget.data.isAddedBookmark
                                                      ? AppColors.orange
                                                      : Colors.white)),
                                  child: FaIcon(
                                    FontAwesomeIcons.solidBookmark,
                                    color: widget.data.isAddedBookmark
                                        ? AppColors.orange
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    widget.data.isLiked = !widget.data.isLiked;
                                    setState(() {});
                                  },
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .copyWith(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  !widget.data.isLiked
                                                      ? AppColors.red
                                                      : Colors.white)),
                                  child: FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    color: widget.data.isLiked
                                        ? AppColors.red
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    widget.data.isAddedCart =
                                        !widget.data.isAddedCart;
                                    setState(() {});
                                  },
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .copyWith(
                                          overlayColor:
                                              MaterialStateProperty.all(!widget
                                                      .data.isAddedCart
                                                  ? AppColors.turquaz.shade100
                                                  : Colors.white)),
                                  child: FaIcon(
                                    FontAwesomeIcons.bagShopping,
                                    color: widget.data.isAddedCart
                                        ? AppColors.turquaz.shade100
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Ürünün sayfasına git',
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
