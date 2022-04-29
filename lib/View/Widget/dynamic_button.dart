import 'package:flutter/material.dart';

class DynamicButton extends StatefulWidget {
  final Function()? onPressed;
  final Widget? child;
  final Size? size;
  final EdgeInsetsGeometry? childPadding;
  final Color? backgroundColor;
  final Color? pressedBackgroundColor;
  final Gradient? gradient;
  final Color? foregroundTextColor;
  final Color? pressedForegroundTextColor;
  final Color? splashColor;
  final Color? shadowColor;
  final Color? pressedShadowColor;
  final double? borderRadius;
  final double? elevation;
  final double? pressedElevation;
  final Duration? animationDuration;
  final BoxBorder? boxBorder;
  const DynamicButton({
    Key? key,
    this.onPressed,
    this.child = const SizedBox(),
    this.size = const Size(120, 40),
    this.childPadding = EdgeInsets.zero,
    this.backgroundColor = Colors.black,
    this.pressedBackgroundColor,
    this.gradient,
    this.foregroundTextColor = Colors.white,
    this.pressedForegroundTextColor = Colors.white,
    this.splashColor = Colors.white,
    this.shadowColor = Colors.black,
    this.pressedShadowColor = Colors.black,
    this.borderRadius = 0,
    this.elevation = 3,
    this.pressedElevation = 5,
    this.animationDuration = const Duration(milliseconds: 150),
    this.boxBorder,
  }) : super(key: key);

  @override
  State<DynamicButton> createState() => _DynamicButtonState();
}

class _DynamicButtonState extends State<DynamicButton> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed ?? () {},
      child: AnimatedContainer(
        width: widget.size!.width,
        height: widget.size!.height,
        padding: widget.childPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          gradient: widget.gradient,
          border: widget.boxBorder,
        ),
        duration: widget.animationDuration!,
        child: widget.child.runtimeType == Text
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FittedBox(fit: BoxFit.fitWidth, child: widget.child),
                ),
              )
            : Center(child: widget.child),
      ),
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(widget.size),
          splashFactory: InkRipple.splashFactory,
          fixedSize: MaterialStateProperty.all(widget.size),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!))),
          backgroundColor: widget.pressedBackgroundColor == null ? MaterialStateProperty.all(widget.backgroundColor) : MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return widget.pressedBackgroundColor;
            }
            return widget.backgroundColor;
          }),
          elevation: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return widget.pressedElevation;
              }
              return widget.elevation;
            },
          ),
          animationDuration: widget.animationDuration,
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return widget.pressedForegroundTextColor;
            }
            return widget.foregroundTextColor;
          }),
          shadowColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return widget.pressedShadowColor;
            }
            return widget.shadowColor;
          }),
          overlayColor: MaterialStateProperty.all(widget.splashColor)),
    );
  }
}
