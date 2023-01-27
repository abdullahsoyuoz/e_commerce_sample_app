import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/Constant/app_menu_constants.dart';
import 'package:sepet_demo/Controller/Provider/theme_provider.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';

class MenuItem extends StatelessWidget {
  final AppMenu? data;
  const MenuItem({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: BouncingWidget(
              onPressed: () {
                settingsCallbackHelper(context, data!.index);
              },
              child: Card(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: LineIcon(
                        Provider.of<ThemeChanger>(context, listen: false)
                                .isDark()!
                            ? data!.icon!
                            : data!.secondaryIcon ?? data!.icon!)),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                data!.title != "theme"
                    ? languageConverter(context, data!.title)!
                    : (Provider.of<ThemeChanger>(context, listen: false)
                                .isDark()!
                            ? ("${languageConverter(context, "light")!} ${languageConverter(context, data!.title)!}")
                            : "${languageConverter(context, "dark")!} ${languageConverter(context, data!.title)!}"),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 21),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
