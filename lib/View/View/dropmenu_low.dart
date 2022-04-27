import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sepet_demo/View/Page/User/Profile/messages.dart';
import 'package:sepet_demo/View/Page/User/Profile/mylist.dart';
import 'package:sepet_demo/View/Page/User/Profile/profile.dart';
import 'package:sepet_demo/View/Style/decorations.dart';

class LowLayerWidget extends StatefulWidget {
  const LowLayerWidget({Key? key}) : super(key: key);

  @override
  State<LowLayerWidget> createState() => _LowLayerWidgetState();
}

class _LowLayerWidgetState extends State<LowLayerWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            boxShadow: appShadow(context)),
        child: ListView(
          shrinkWrap: true,
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.solidUser,
              ),
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              ),
            ),
            IconButton(
                icon: const Icon(
                  FontAwesomeIcons.box,
                ),
                onPressed: () {}),
            IconButton(
                icon: const Icon(
                  FontAwesomeIcons.solidHeart,
                ),
                onPressed: () {}),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.solidBookmark,
              ),
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const MyListPage(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.solidPaperPlane,
              ),
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const MessagesPage(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.solidBell,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
