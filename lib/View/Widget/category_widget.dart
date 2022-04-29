import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/category.dart';
import 'dart:ui' as ui;

class CategoryWidget extends StatelessWidget {
  final Category data;
  const CategoryWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 3,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipPath(
              clipper: CustomCliper(),
              child: SizedBox(
                  width: context.width,
                  height: 120,
                  child: Image.network(
                    data.imageUrl!,
                    fit: BoxFit.cover,
                  )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                data.title,
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 27),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCliper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.9, 0);
    path.lineTo(size.width * 0.7, size.height);
    path.lineTo(size.width * 0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

class FadePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.5, size.height * 0.4),
        Offset(size.width * 0.5, size.height),
        [
          Colors.white,
          Colors.transparent,
        ],
      )
      ..blendMode = BlendMode.dstATop;

    canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
