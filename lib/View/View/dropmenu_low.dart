import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepet_demo/Model/Dummy/user.dart';
import 'package:sepet_demo/View/Page/User/Profile/messages.dart';
import 'package:sepet_demo/View/Page/User/Profile/mylist.dart';
import 'package:sepet_demo/View/Page/User/Profile/profile.dart';

Widget buildLowLayerWidget(BuildContext context) {
  return SizedBox.expand(
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ProfilePage(),
                        )),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Theme.of(context).iconTheme.color!, width: 3),
                        image: DecorationImage(
                          image: NetworkImage(loginUser.photoUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 20),
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            loginUser.name! + '',
                            style: GoogleFonts.josefinSans(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                FontAwesomeIcons.solidBell,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
