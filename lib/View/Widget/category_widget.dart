import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/category.dart';
import 'package:sepet_demo/View/Clipper/category_widget_clipper.dart';
import 'dart:ui' as ui;

import 'package:sepet_demo/View/Widget/bouncing_widget.dart';

class CategoryWidget extends StatefulWidget {
  final Category data;
  const CategoryWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final GlobalKey _widgetKey = GlobalKey();

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
    return BouncingWidget(
      onPressed: () {},
      child: Stack(
        key: _widgetKey,
        fit: StackFit.expand,
        children: [
          ClipRect(
            child: ImageFiltered(
                imageFilter: ui.ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Image.network(
                  widget.data.imageUrl!,
                  fit: BoxFit.cover,
                  color: Theme.of(context).iconTheme.color!.withOpacity(.25),
                  colorBlendMode: BlendMode.darken,
                )),
          ),
          ClipRect(
            child: ClipPath(
              clipper: CategoryClipper(),
              child: Image.network(
                widget.data.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                widget.data.title,
                textAlign: TextAlign.start,
                style:
                    Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
