// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

class BouncingWidget extends StatefulWidget {
  /// Set it to `null` to disable `onTap`.
  final VoidCallback? onPressed;
  final void Function(TapUpDetails)? onTapUp;
  final void Function(TapDownDetails)? onTapDown;
  final VoidCallback? onTapCancel;

  /// The reverse duration of the scaling animation when `onTapUp`.
  final Duration duration;

  /// The duration of the scaling animation when `onTapDown`.
  final Duration reverseDuration;

  /// The reverse curve of the scaling animation when `onTapUp`.
  final Curve curve;

  /// The curve of the scaling animation when `onTapDown`..
  final Curve reverseCurve;

  /// The scale factor of the child widget. The valid range of `scaleFactor` is from `0.0` to `1.0`.
  final double scaleFactor;

  final Widget? child;

  const BouncingWidget({
    Key? key,
    this.onPressed,
    this.child,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.duration = const Duration(milliseconds: 150),
    this.reverseDuration = const Duration(milliseconds: 150),
    this.curve = Curves.decelerate,
    this.reverseCurve = Curves.decelerate,
    this.scaleFactor = 0.7,
  })  : assert(
          scaleFactor >= 0.0 && scaleFactor <= 1.0,
          "The valid range of scaleFactor is from 0.0 to 1.0.",
        ),
        super(key: key);

  @override
  _BouncingWidgetState createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      value: 1.0,
      upperBound: 1.0,
      lowerBound: widget.scaleFactor,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onTap() {
      if (widget.onPressed != null) {
        Timer(widget.duration * 2, () {
          widget.onPressed!();
        });
      }

      _controller.reverse().then((_) {
        _controller.forward();
      });
    }

    void onTapUp(TapUpDetails details) {
      if (widget.onTapUp != null) widget.onTapUp!(details);
      _controller.forward();
    }

    void onTapDown(TapDownDetails details) {
      if (widget.onTapDown != null) widget.onTapDown!(details);
      _controller.reverse();
    }

    void onTapCancel() {
      if (widget.onTapCancel != null) widget.onTapCancel!();
      _controller.forward();
    }

    return GestureDetector(
      onTapCancel: widget.onPressed != null ? onTapCancel : null,
      onTapDown: widget.onPressed != null ? onTapDown : null,
      onTapUp: widget.onPressed != null ? onTapUp : null,
      onTap: widget.onPressed != null ? onTap : null,
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
          reverseCurve: widget.reverseCurve,
        ),
        child: widget.child,
      ),
    );
  }
}
