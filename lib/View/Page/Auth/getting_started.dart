import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/Constant/languages.dart';
import 'package:sepet_demo/Controller/Provider/theme_provider.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Page/Auth/onboaring.dart';
import 'package:sepet_demo/View/Painter/vertical_half_painter.dart';
import 'package:sepet_demo/View/Style/Theme/themedata.dart';
import 'package:sepet_demo/View/Style/textstyle.dart';
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
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: HalfPainter(
              rightColor: Theme.of(context).colorScheme.tertiaryContainer,
            ),
          ),
          SizedBox.expand(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                            vertical: context.padding.top * 1.5),
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      languageConverter(
                                          context, "gettingStarted"),
                                      style: getAccentBoldStyle(),
                                    ),
                                  ),
                                  LogoWidget(
                                    size: context.width * 0.15,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                top: 50,
                                bottom: 20,
                              ),
                              child: Text(
                                languageConverter(
                                    context, 'chooseYourLanguage'),
                                style: getAccentBoldStyle(),
                              ),
                            ),
                            SizedBox(
                              height: 90,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(left: 20),
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                itemCount: languageList.length,
                                itemBuilder: (context, index) {
                                  final data = languageList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        BouncingWidget(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          onPressed: () {
                                            SharedPreferences.getInstance()
                                                .then((value) {
                                              value.setString("lang",
                                                  data.locale.languageCode);
                                              AppLocalizations.of(context)
                                                  .load();
                                              setState(() {});
                                            });
                                          },
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Image.asset(data.icon),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(data.title,
                                              style:
                                                  getTextFieldStyle(context)),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                top: 30,
                                bottom: 20,
                              ),
                              child: Text(
                                languageConverter(context, 'chooseYourTheme'),
                                style: getAccentBoldStyle(),
                              ),
                            ),
                            SizedBox(
                              height: 90,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(left: 20),
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                itemCount: themeList.length,
                                itemBuilder: (context, index) {
                                  final data = themeList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        BouncingWidget(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            onPressed: () {
                                              Provider.of<ThemeChanger>(context,
                                                      listen: false)
                                                  .setTheme(data.brightness ==
                                                          Brightness.dark
                                                      ? true
                                                      : false);
                                            },
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    color: data
                                                        .scaffoldBackgroundColor,
                                                    border: Border.all(
                                                        color: Theme.of(context)
                                                            .iconTheme
                                                            .color,
                                                        width: 2),
                                                    shape: BoxShape.circle),
                                              ),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            data.brightness == Brightness.dark
                                                ? languageConverter(
                                                    context, "dark")
                                                : languageConverter(
                                                    context, "light"),
                                            textAlign: TextAlign.center,
                                            style: getTextFieldStyle(context),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30.0, top: 30),
                      child: BouncingWidget(
                        key: LabeledGlobalKey('submitButton'),
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          languageConverter(context, 'letStarted'),
                          style: getAccentStyle(),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const OnboardPage(),
                              ));
                        },
                        // icon: const Icon(FontAwesomeIcons.chevronRight),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
