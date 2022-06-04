// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:flutter/material.dart';

class StackedCarousel extends StatefulWidget {
  int itemCount;
  double aspectRatio;
  double itemAspectRatio;
  bool reverse;
  bool verticalScrolling;
  double padding;
  double incrementalVerticalPadding;
  Function(int index) onPageChanged;
  Function(PageController pageController) pageControllerCallback;
  IndexedWidgetBuilder itemBuilder;

  StackedCarousel({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    this.itemAspectRatio = 4 / 5,
    this.aspectRatio = 1,
    this.reverse = false,
    this.padding = 20,
    this.incrementalVerticalPadding = 20,
    this.verticalScrolling = false,
    this.onPageChanged,
    this.pageControllerCallback,
  })  : assert(itemAspectRatio >= 0.45),
        assert(itemCount != null && itemCount > 0),
        assert(itemBuilder != null),
        super(key: key);
  @override
  StackedCarouselState createState() => StackedCarouselState();
}

class StackedCarouselState extends State<StackedCarousel> {
  PageController pageController;
  double currentPageIndex = 0.0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex.toInt());
    pageController.addListener(() {
      setState(() {
        currentPageIndex = pageController.page;
      });
    });
    widget.pageControllerCallback.call(pageController);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          CustomWidget(
            currentPageIndex,
            widget.itemCount,
            widget.itemBuilder,
            widget.reverse,
            widget.padding,
            widget.incrementalVerticalPadding,
            widget.aspectRatio,
            widget.itemAspectRatio,
            widget.verticalScrolling,
          ),
          Positioned.fill(
            child: PageView.builder(
              controller: pageController,
              reverse: widget.reverse,
              scrollDirection:
                  widget.verticalScrolling ? Axis.vertical : Axis.horizontal,
              onPageChanged: (value) {
                if (widget.onPageChanged != null) {
                  widget.onPageChanged(value);
                }
              },
              itemCount: widget.itemCount,
              itemBuilder: (context, index) {
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomWidget extends StatefulWidget {
  double currentPageIndex;
  int itemCount;
  IndexedWidgetBuilder itemBuilder;
  bool reverse;
  bool verticalScrolling;
  double padding;
  double incrementalVerticalPadding;
  double aspectRatio;
  double itemAspectRatio;

  CustomWidget(
      this.currentPageIndex,
      this.itemCount,
      this.itemBuilder,
      this.reverse,
      this.padding,
      this.incrementalVerticalPadding,
      this.aspectRatio,
      this.itemAspectRatio,
      this.verticalScrolling,
      {Key key})
      : super(key: key);
  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          //  Constants
          List<Widget> stackWidgets = [];
          double cardAspectRatio = widget.itemAspectRatio;
          double padding = widget.padding;
          double incrementalPadding = widget.incrementalVerticalPadding;
          double intervalLeft =
              (constraints.maxHeight * cardAspectRatio) + padding;
          double intervalRight = (constraints.maxWidth -
                  ((constraints.maxHeight * cardAspectRatio))) /
              2;

          for (var index = 0; index < widget.itemCount; index++) {
            double end = 0;
            double currentPosition = -(widget.currentPageIndex - index);

            if (currentPosition <= 0) {
              end = padding +
                  intervalRight * 2 -
                  (intervalLeft * currentPosition);
            } else {
              end = padding + intervalRight * (2 - currentPosition);
            }
            if (end < padding) end = padding;
            Widget card;
            widget.verticalScrolling
                ? card = Positioned.directional(
                    start:
                        padding + max(currentPosition, 0) * incrementalPadding,
                    end: padding + max(currentPosition, 0) * incrementalPadding,
                    top: widget.reverse ? end : null,
                    bottom: widget.reverse ? null : end,
                    textDirection: TextDirection.ltr,
                    child: AspectRatio(
                      aspectRatio: cardAspectRatio,
                      child: widget.itemBuilder(context, index),
                    ),
                  )
                : card = Positioned.directional(
                    top: padding + max(currentPosition, 0) * incrementalPadding,
                    bottom:
                        padding + max(currentPosition, 0) * incrementalPadding,
                    end: widget.reverse ? null : end,
                    start: widget.reverse ? end : null,
                    textDirection: TextDirection.ltr,
                    child: AspectRatio(
                      aspectRatio: cardAspectRatio,
                      child: widget.itemBuilder(context, index),
                    ),
                  );

            stackWidgets.add(card);
          }
          stackWidgets = stackWidgets.reversed.toList();
          return Stack(
            fit: StackFit.expand,
            children: stackWidgets,
          );
        },
      ),
    );
  }
}
