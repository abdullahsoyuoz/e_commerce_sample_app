import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/Dummy/flows.dart';
import 'package:sepet_demo/View/View/appbar.dart';
import 'package:sepet_demo/View/View/dropmenu_low.dart';
import 'package:sepet_demo/View/Widget/drop_menu.dart';
import 'package:sepet_demo/View/Widget/flow_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;

  @override
  void initState() {
    if (mounted) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
      super.initState();
    }
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
      body: DropMenu(
        decoration: const BoxDecoration(boxShadow: [BoxShadow(blurRadius: 3)]),
        backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
        lowLayerHeight: 70,
        lowLayerBottomPadding: MediaQuery.of(context).padding.bottom,
        lowLayer: buildLowLayerWidget(context),
        indicator: const SizedBox(),
        animationController: _animationController,
        highLayer: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButton: FloatingActionButton(
            child: const FaIcon(
              FontAwesomeIcons.solidUser,
            ),
            onPressed: () => toggleDropMenu(),
          ),
          appBar: homeAppbar(context),
          body: ListView.builder(
            shrinkWrap: true,
            physics: const PageScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: flowList.length,
            itemExtent: (context.height - context.padding.top - 70) * 0.25,
            itemBuilder: (context, index) {
              return FlowWidget(data: flowList[index]);
            },
          ),
        ),
      ),
    );
  }

  void toggleDropMenu() {
    if (!_animationController.isAnimating && _animationController.value == 0) {
      _animationController.forward();
    }
    if (!_animationController.isAnimating && _animationController.value == 1) {
      _animationController.reverse();
    }
  }
}
