import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/View/flow_product_body_view.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';

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
      resizeToAvoidBottomInset: false,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                              .color!,
                                          width: lineThickness()),
                                      borderRadius: appRadius(context)),
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
                              ],
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
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: hasSubscribe
                                    ? AppColors.red
                                    : Theme.of(context).iconTheme.color!,
                                width: lineThickness()),
                            borderRadius: appRadius(context),
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 40,
                              minHeight: 40,
                            ),
                            child: FittedBox(
                              alignment: Alignment.center,
                              child: Swing(
                                child: LineIcon(
                                  LineIcons.bell,
                                  color: hasSubscribe
                                      ? AppColors.red
                                      : Theme.of(context).iconTheme.color,
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

