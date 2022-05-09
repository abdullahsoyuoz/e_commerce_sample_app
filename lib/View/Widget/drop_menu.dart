import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Style/colors.dart';

class DropMenu extends StatefulWidget {
  final Widget? lowLayer;

  final Widget? highLayer;

  final Widget? indicator;

  /// call the widget's initState again so that the change can be applied.
  final double? lowLayerHeight;

  /// call the widget's initState again so that the change can be applied.
  final double? lowLayerBottomPadding;

  /// The color of the underlying area, given the padding value.
  final Color? backgroundColor;

  final Color? dividerColor;

  ///
  // Function(bool isOpen)? openCallback;
  final VoidCallback? onTabCallback;

  final AnimationController animationController;

  final BoxDecoration? decoration;
  const DropMenu({
    Key? key,
    this.highLayer,
    this.indicator,
    this.lowLayer,
    this.lowLayerHeight = 100,
    this.lowLayerBottomPadding = 0,
    this.decoration,
    this.backgroundColor = Colors.transparent,
    this.dividerColor = const Color(0xffeeeeee),
    // this.openCallback,
    this.onTabCallback,
    required this.animationController,
  }) : super(key: key);

  @override
  State<DropMenu> createState() => _DropMenuState();
}

class _DropMenuState extends State<DropMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _animationController = widget.animationController;
    _animation = Tween<double>(
      begin: 0,
      end: -(widget.lowLayerHeight! + widget.lowLayerBottomPadding!),
    ).animate(_animationController);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: ColoredBox(
        color: widget.backgroundColor!,
        child: Stack(
          children: [
            _buildLowLayerWidget(context),
            _buildHighLayerWidget(context),
            _buildGesture(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGesture(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom == 0
                ? 50
                : MediaQuery.of(context).padding.bottom),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              return Transform.translate(
                offset: Offset(0, _animation.value),
                child: GestureDetector(
                  onTap: () {
                    if (!_animationController.isAnimating) {
                      if (_animationController.value == 0) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    }
                  },
                  onVerticalDragUpdate: (details) {
                    if (!_animationController.isAnimating) {
                      details.delta.dy < 0
                          ? _animationController.forward()
                          : _animationController.reverse();
                    }
                  },
                  child: ColoredBox(
                    color: Colors.red.withOpacity(0),
                    child: widget.indicator ??
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 30,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: AppColors.purple,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              // Align(
                              //   alignment: Alignment.centerRight,
                              //   child: Container(
                              //     width: 20,
                              //     height: 20,
                              //     decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLowLayerWidget(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (!_animationController.isAnimating) {
          details.delta.dy < 0
              ? _animationController.forward()
              : _animationController.reverse();
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: lerpDouble(
                    widget.lowLayerHeight! + 0,
                    widget.lowLayerHeight! + widget.lowLayerBottomPadding!,
                    _animationController.value)!,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: widget.lowLayerHeight!,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: child,
                ),
              ),
            );
          },
          child: Center(
            child: widget.lowLayer ?? const SizedBox(),
          ),
        ),
      ),
    );
  }

  Widget _buildHighLayerWidget(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: DecoratedBox(
          decoration: widget.decoration ?? const BoxDecoration(),
          child: widget.highLayer ?? const SizedBox(),
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
    );
  }
}
