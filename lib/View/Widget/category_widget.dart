import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Model/category.dart';

class CategoryWidget extends StatelessWidget {
  final Category data;
  const CategoryWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
      ),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Center(
              child: FaIcon(
                data.icon,
                color: Provider.of<ThemeChanger>(context, listen: false)
                        .isDark()
                    ? data.color!.shade100
                    : data.color!.shade300,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
