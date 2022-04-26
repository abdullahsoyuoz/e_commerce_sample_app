import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:shimmer/shimmer.dart';

class FlowShimmerWidget extends StatelessWidget {
  const FlowShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      key: _scaffoldKey,
      body: Shimmer(
        gradient: LinearGradient(colors: [Theme.of(context).colorScheme.secondaryContainer, Theme.of(context).colorScheme.primaryContainer]),
        child: SizedBox(
          width: context.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox.expand(
                  child: ColoredBox(color: Theme.of(context).colorScheme.primaryContainer),
                )
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 20,
                    width: Random().nextDouble() * context.width,
                    color: Colors.black,
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
