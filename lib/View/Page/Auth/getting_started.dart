import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/Constant/languages.dart';
import 'package:sepet_demo/Controller/Provider/theme_provider.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Page/Auth/onboaring.dart';
import 'package:sepet_demo/View/Style/Theme/themedata.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key key}) : super(key: key);

  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: context.padding.top),
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: LogoWidget(
                    size: context.width * 0.2,
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Text(
                  languageConverter(context, "gettingStarted"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
                child: Text(
                  languageConverter(context, 'chooseYourLanguage'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: languageList.length,
                  itemBuilder: (context, index) {
                    final data = languageList[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          BouncingWidget(
                            duration: const Duration(milliseconds: 300),
                            onPressed: () {
                              SharedPreferences.getInstance().then((value) {
                                value.setString(
                                    "lang", data.locale.languageCode);
                                AppLocalizations.of(context).load();
                                setState(() {});
                              });
                            },
                            child: Image.asset(
                              data.icon,
                              width: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              data.title,
                              style: const TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                child: Text(
                  languageConverter(context, 'chooseYourTheme'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: themeList.length,
                  itemBuilder: (context, index) {
                    final data = themeList[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          BouncingWidget(
                              duration: const Duration(milliseconds: 300),
                              onPressed: () {
                                Provider.of<ThemeChanger>(context,
                                        listen: false)
                                    .setTheme(data.brightness == Brightness.dark
                                        ? true
                                        : false);
                              },
                              child: Card(
                                elevation: 0,
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: data.scaffoldBackgroundColor,
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            width: 2),
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              data.brightness == Brightness.dark
                                  ? languageConverter(context, "dark")
                                  : languageConverter(context, "light"),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                key: LabeledGlobalKey('submitButton'),
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const OnboardPage(),));
                },
                icon: const Icon(FontAwesomeIcons.chevronRight)
              )
            ],
          ),
        ),
      ),
    );
  }
}
