// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Style/textstyle.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

class FlowListWidget extends StatefulWidget {
  FlowEntity data;
  FlowListWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<FlowListWidget> createState() => _FlowListWidgetState();
}

class _FlowListWidgetState extends State<FlowListWidget> {
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
    return SizedBox(
      width: context.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Transform.scale(
              scale: 0.5,
              alignment: Alignment.topLeft,
              child: SizedBox.expand(
                  child: ColoredBox(color: Provider.of<ThemeChanger>(context,listen: false).isDark ? widget.data.color!.shade100 : widget.data.color!)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
              widget.data.imageUrl!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingIndicator(context, child, loadingProgress),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      widget.data.title!
                              .replaceAll('_', ' ')
                              .replaceAll('-', ' ')
                              .toUpperCase() +
                          '',
                      style: getBlackBackgroundStyle(context),
                      maxLines: 3,
                    ),
                  ),
                  widget.data.targetProducts == null
                      ? const SizedBox()
                      : BouncingWidget(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => FlowListProductsView(
                                  data: widget.data,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            ' İncele '.toUpperCase(),
                            style: getBlackBackgroundStyle(context),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double discountedCalculate(double price, int? rate) {
    if (rate == null) {
      return price;
    } else {
      return price - ((price * rate) / 100);
    }
  }
}

class FlowListProductsView extends StatefulWidget {
  late FlowEntity data;
  FlowListProductsView({Key? key, required this.data}) : super(key: key);

  @override
  State<FlowListProductsView> createState() => _FlowListProductsViewState();
}

class _FlowListProductsViewState extends State<FlowListProductsView> {
  late PageController _pageController;
  int pageIndex = 0;
  late List<PaletteColor> colors;
  @override
  void initState() {
    _updatePaletteGenerator();
    super.initState();
    _pageController = PageController(initialPage: 0);
    colors = List.generate(widget.data.targetProducts!.length,
        (index) => PaletteColor(Colors.white, 1));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _updatePaletteGenerator() async {
    for (var i = 0; i < widget.data.targetProducts!.length; i++) {
      final PaletteGenerator generator =
          await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.data.targetProducts![i].photosUrl![0]),
        size: const Size(50, 50),
      );
      colors[i] = generator.lightMutedColor ?? PaletteColor(Colors.white, 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors[pageIndex].color.withOpacity(0.75),
          ),
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
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0, bottom: 100, left: 20, right: 20),
                    child: Column(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 3)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.network(
                              widget.data.targetProducts![index].photosUrl![0],
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) =>
                                      loadingIndicator(
                                          context, child, loadingProgress),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox.expand(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget
                                            .data.targetProducts![index].title!,
                                        style: getBlackBackgroundStyle(context)
                                            .copyWith(fontSize: 21),
                                      ),
                                      Text(
                                        widget.data.targetProducts![index]
                                            .description!,
                                        style: getBlackBackgroundStyle(context)
                                            .copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: const FaIcon(
                                              FontAwesomeIcons.bagShopping),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: const Text(
                                              'Ürün Detayı',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
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
                },
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const FaIcon(FontAwesomeIcons.chevronLeft)),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 20,
                              minHeight: 20,
                            ),
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.fitWidth,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0,
                                ),
                                child: Text(
                                  widget.data.title!.toUpperCase() + ' #' + (pageIndex + 1).toString(),
                                  // overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
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
    );
  }
}
