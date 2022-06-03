// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Style/Theme/light.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Widget/StackedCarousel.dart';
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

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: widget.palette.dominantColor.color,
        body: NestedScrollView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            headerSliverBuilder: (context, bodyIsScrolled) {
              return [
                SliverAppBar(
                  toolbarHeight: 0,
                  expandedHeight: 300,
                  collapsedHeight: 70,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30))),
                  automaticallyImplyLeading: false,
                  stretch: true,
                  pinned: false,
                  floating: false,
                  stretchTriggerOffset: 20,
                  snap: false,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    stretchModes: const [StretchMode.blurBackground],
                    background: ColoredBox(
                      color: widget.palette.dominantColor.color,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: StackedCarousel(
                              itemAspectRatio:
                                  context.width / (300 + context.padding.top),
                              aspectRatio:
                                  context.width / (300 + context.padding.top),
                              verticalScrolling: false,
                              reverse: false,
                              padding: 0,
                              incrementalVerticalPadding: 40,
                              pageControllerCallback: (c) {
                                _pageController = c;
                              },
                              onPageChanged: (i) {
                                setState(() {});
                              },
                              itemCount: widget.data.photosUrl.length,
                              itemBuilder: (context, index) {
                                final data = widget.data.photosUrl[index];
                                return ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(30)),
                                    child:
                                        Image.network(data, fit: BoxFit.cover));
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: widget.data.photosUrl.length,
                                effect: ExpandingDotsEffect(
                                  activeDotColor: AppColors.purple.shade300,
                                  dotColor: widget
                                      .palette.dominantColor.titleTextColor
                                      .withOpacity(.5),
                                ),
                                onDotClicked: (page) {
                                  _pageController.animateToPage(
                                    page,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: context.padding.top, left: 10),
                              child: IconButton(
                                icon: CircleAvatar(
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: Builder(
                                    builder: (context) {
                                      return Center(
                                        child: LineIcon(
                                          LineIcons.arrowLeft,
                                          color: Theme.of(context).iconTheme.color,
                                        ),
                                      );
                                    }
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: SizedBox.expand(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(top: context.padding.top),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                widget.data.title,
                                style: TextStyle(
                                  color: widget
                                      .palette.dominantColor.bodyTextColor
                                      .withAlpha(255),
                                  fontSize: 30,
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
            )));
  }
}
