import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Model/category.dart';

// ignore: must_be_immutable
class CategoryWidget extends StatelessWidget {
  Category data;
  CategoryWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
      ),
      child: ColoredBox(
        color: Theme.of(context).appBarTheme.backgroundColor!,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FittedBox(
                  child: Center(
                    child: FaIcon(
                      data.icon,
                      color: Provider.of<ThemeChanger>(context, listen: false)
                              .isDark
                          ? data.color!.shade100
                          : data.color!.shade300,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  data.title  + '',
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 21),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
