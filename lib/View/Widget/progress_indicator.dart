import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'dart:math' as math;

Future<void> showWaitDialog(BuildContext context,
    {String title = '',
    CustomProgressIndicatorType type =
        CustomProgressIndicatorType.bounce}) async {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    useSafeArea: true,
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: WillPopScope(
          onWillPop: () async => true,
          child: Dialog(
            elevation: 0,
            alignment: Alignment.center,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: CustomProgressIndicator(
              title: title,
              type: type,
            ),
          ),
        ),
      );
    },
  );
}

enum CustomProgressIndicatorType { bounce, angle, clock }

class CustomProgressIndicator extends StatefulWidget {
  final String title;
  final CustomProgressIndicatorType type;
  const CustomProgressIndicator({Key key, this.title, this.type})
      : super(key: key);

  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.repeat(
          reverse:
              widget.type == CustomProgressIndicatorType.bounce ? true : false);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: context.width,
          height: context.width,
          child: CustomPaint(
            painter: ProgressPainter(_animationController, type: widget.type),
            child: Center(
              child: Text(
                widget.title.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  ProgressPainter(this.animation, { this.type})
      : super(repaint: animation) {
    curve = CurvedAnimation(
      parent: animation,
      curve: Curves.linear,
    );
  }
   Animation<double> animation;
   Animation curve;
   CustomProgressIndicatorType type;

  @override
  void paint(Canvas canvas, Size size) {
    switch (type) {
      case CustomProgressIndicatorType.clock:
        clockPaint(canvas, size);
        break;
      case CustomProgressIndicatorType.angle:
        anglePaint(canvas, size);
        break;
      case CustomProgressIndicatorType.bounce:
        bouncePaint(canvas, size);
        break;
      default:
        bouncePaint(canvas, size);
    }
    // anglePaint(canvas, size);
  }

  void bouncePaint(Canvas canvas, Size size) {
    canvas.drawArc(
        Rect.fromLTRB(
          lerpDouble(size.width * .45, -size.width, curve.value),
          lerpDouble(size.width * .45, -size.width, curve.value),
          lerpDouble(size.width * 0.55, size.width * 2, curve.value),
          lerpDouble(size.width * 0.55, size.width * 2, curve.value),
        ),
        math.pi * 1.5,
        math.pi * 2,
        true,
        Paint()
          ..style = PaintingStyle.fill
          ..color = AppColors.purple);
  }

  void anglePaint(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromPoints(Offset(-size.width, -size.height),
          Offset(size.width * 2, size.height * 2)),
      math.pi * 2 * curve.value,
      math.pi * 1,
      true,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Color.lerp(
            AppColors.purple.shade200, AppColors.purple.shade200, curve.value)
        ..strokeWidth = 20
        ..strokeCap = StrokeCap.round,
    );
  }

  void clockPaint(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromPoints(Offset(-size.width, -size.height),
          Offset(size.width * 2, size.height * 2)),
      math.pi * 1.5,
      lerpDouble(-math.pi * 2, math.pi * 2, curve.value),
      true,
      Paint()
        ..style = PaintingStyle.fill
        ..color = AppColors.purple,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
