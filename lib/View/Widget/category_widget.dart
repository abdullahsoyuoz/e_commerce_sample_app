import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sepet_demo/Model/category.dart';

// ignore: must_be_immutable
class CategoryWidget extends StatelessWidget {
  Category data;
  CategoryWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 3,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: data.color!, width: 5),
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  data.color!.shade200.withOpacity(0.3),
                  data.color!.shade300.withOpacity(0.3),
                ],
                stops: const [0, 0.5]
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        data.title
                            .replaceAll('_', '\n')
                            .replaceAll('-', ' ')
                            .toLowerCase(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 10000),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FittedBox(
                      child: Center(
                        child: FaIcon(
                          data.icon,
                          color: data.color!.shade100,
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
    );
  }
}
