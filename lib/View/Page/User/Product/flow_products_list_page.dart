import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/Provider/flows_provider.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Page/User/Product/product_detail.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/View/flow_product_body_view.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';

class FlowProductsListPage extends StatefulWidget {
  final FlowEntity data;
  const FlowProductsListPage({Key? key, required this.data}) : super(key: key);

  @override
  State<FlowProductsListPage> createState() => _FlowProductsListPageState();
}

class _FlowProductsListPageState extends State<FlowProductsListPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;
  late AnimationController? _bellAnimationController;

  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
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
      body: Padding(
        padding: EdgeInsets.only(top: context.padding.top * 1.5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Material(
                            elevation: 10,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: appRadius(),
                            ),
                            child: const Center(
                              child: FaIcon(
                                LineIcons.arrowLeft,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: BouncingWidget(
                          onPressed: () {},
                          child: AbsorbPointer(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 40,
                                  minHeight: 40,
                                ),
                                child: Material(
                                  elevation: 10,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: appRadius()),
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
                          ),
                        ),
                      ),
                      Consumer<FlowsProvider>(builder: (context, provider, _) {
                        return BouncingWidget(
                          onPressed: () {
                            provider
                                .followedListToggleItem(widget.data)
                                .then((check) {
                              if (provider.isFollowed(widget.data)) {
                                _bellAnimationController
                                    ?.forward()
                                    .whenComplete(() {
                                  _bellAnimationController?.reset();
                                });
                              }
                            });
                          },
                          child: Material(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: appRadius()),
                            color: provider.isFollowed(widget.data)
                                ? AppColors.red
                                : Theme.of(context).scaffoldBackgroundColor,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 40,
                                minHeight: 40,
                              ),
                              child: FittedBox(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(7),
                                  child: Swing(
                                    child: LineIcon(
                                      LineIcons.bell,
                                      color: Theme.of(context).iconTheme.color,
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
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) => pageIndex = index,
                pageSnapping: true,
                physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: widget.data.targetProducts!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: BouncingWidget(
                      onPressed: () {
                        Navigator.push(
                            context, CupertinoPageRoute(builder: (context) => ProductDetailPage(data: widget.data.targetProducts![index]),));
                      },
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 0.6,
                          child: Card(
                            elevation: 30,
                            shape: RoundedRectangleBorder(
                                borderRadius: appRadius()),
                            child: ProductViewBody(
                                data: widget.data.targetProducts![index],
                                index: index),
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
}
