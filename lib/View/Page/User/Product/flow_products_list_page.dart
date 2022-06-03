import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/Provider/flows_provider.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Page/User/Product/product_detail.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Style/palette_generator.dart';
import 'package:sepet_demo/View/View/flow_product_body_view.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';

class FlowProductsListPage extends StatefulWidget {
  final FlowEntity data;
  const FlowProductsListPage({Key key, this.data}) : super(key: key);

  @override
  State<FlowProductsListPage> createState() => _FlowProductsListPageState();
}

class _FlowProductsListPageState extends State<FlowProductsListPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController;
  AnimationController _bellAnimationController;

  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
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
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _appBar(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) => pageIndex = index,
                pageSnapping: true,
                physics:
                    const PageScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: widget.data.targetProducts.length,
                itemBuilder: (context, index) {
                  final data = widget.data.targetProducts[index];
                  return BouncingWidget(
                    onPressed: () {
                      PaletteGenerator _palette;
                      generatePalette(data.photosUrl[0]).then((value) {
                        _palette = value;
                      }).whenComplete(() {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          return ProductDetailPage(
                            data: data,
                            palette: _palette,
                          );
                        }));
                      });
                    },
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 0.625,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            child: ProductViewBody(data: data, index: index),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3,
            sigmaY: 3,
          ),
          child: SizedBox(
            height: 70 + context.padding.top,
            child: AppBar(
              toolbarHeight: 70,
              centerTitle: false,
              elevation: 0,
              backgroundColor: Theme.of(context)
                  .appBarTheme
                  .backgroundColor
                  .withOpacity(0.1),
              automaticallyImplyLeading: false,
              title: SizedBox(
                height: 50,
                width: context.width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: LineIcon(
                        LineIcons.arrowLeft,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      flex: 6,
                      child: Consumer<FlowsProvider>(
                          builder: (context, provider, _) {
                        return BouncingWidget(
                          onPressed: () {
                            provider
                                .followedListToggleItem(widget.data)
                                .then((check) {
                              if (provider.isFollowed(widget.data)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: AppColors.red.shade300,
                                  content: const Text(
                                    'Akış takibe alındı.',
                                  ),
                                ));
                                _bellAnimationController
                                    .forward()
                                    .whenComplete(() {
                                  _bellAnimationController?.reset();
                                });
                              }
                            });
                          },
                          child: Card(
                            child: AbsorbPointer(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: Material(
                                        elevation: 0,
                                        color: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: appRadius()),
                                        child: Marquee(
                                          numberOfRounds: 3,
                                          scrollAxis: Axis.horizontal,
                                          fadingEdgeStartFraction: 0.02,
                                          fadingEdgeEndFraction: 0.03,
                                          showFadingOnlyWhenScrolling: true,
                                          velocity: 30,
                                          decelerationDuration:
                                              const Duration(seconds: 3),
                                          startAfter:
                                              const Duration(seconds: 1),
                                          startPadding: 20,
                                          blankSpace: context.width * 0.5,
                                          text: widget.data.title.toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxHeight: 40,
                                        minHeight: 40,
                                        maxWidth: 40,
                                        minWidth: 40),
                                    child: FittedBox(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(7),
                                        child: Swing(
                                          child: LineIcon(
                                            LineIcons.bell,
                                            color:
                                                provider.isFollowed(widget.data)
                                                    ? AppColors.red
                                                    : Theme.of(context)
                                                        .iconTheme
                                                        .color,
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
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
