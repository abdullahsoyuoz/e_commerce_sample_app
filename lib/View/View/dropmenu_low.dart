import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Model/Dummy/user.dart';
import 'package:sepet_demo/View/Page/User/Profile/messages.dart';
import 'package:sepet_demo/View/Page/User/Profile/my_orders.dart';
import 'package:sepet_demo/View/Page/User/Profile/mylist.dart';
import 'package:sepet_demo/View/Page/User/Profile/notify.dart';
import 'package:sepet_demo/View/Page/User/Profile/profile.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

class LowLayerWidget extends StatefulWidget {
  const LowLayerWidget({Key key}) : super(key: key);

  @override
  State<LowLayerWidget> createState() => _LowLayerWidgetState();
}

class _LowLayerWidgetState extends State<LowLayerWidget> {
  ScrollController _scrollController;

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
    return Material(
      child: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              boxShadow: appShadow(context)),
          child: ListView(
            shrinkWrap: true,
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 100),
            children: [
              IconButton(
                iconSize: 50,
                icon: AdvancedAvatar(
                  size: 50,
                  child: Image.network(
                    loginUser.photoUrl,
                    loadingBuilder: loadingIndicator,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                ),
              ),
              Tooltip(
                message: 'Siparişlerin',
                child: IconButton(
                  icon: const Icon(
                    LineIcons.archive,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const MyOrdersPage(),
                    ),
                  ),
                ),
              ),
              Tooltip(
                message: 'Beğendiklerin',
                child: IconButton(
                  icon: const Icon(
                    LineIcons.heart,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const MyListPage(),
                    ),
                  ),
                ),
              ),
              Tooltip(
                message: 'Listelerin',
                child: IconButton(
                  icon: const Icon(
                    LineIcons.bookmark,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const MyListPage(),
                    ),
                  ),
                ),
              ),
              Tooltip(
                message: 'Satıcıya soruların',
                child: IconButton(
                  icon: const Icon(
                    LineIcons.envelope,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const MessagesPage(),
                    ),
                  ),
                ),
              ),
              Tooltip(
                message: 'Bildirimler',
                child: IconButton(
                  icon: const Icon(
                    LineIcons.bell,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const NotifyPage(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
