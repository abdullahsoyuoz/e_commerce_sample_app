import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/Model/Dummy/flows.dart';
import 'package:sepet_demo/Model/Dummy/products.dart';
import 'package:sepet_demo/View/Style/themedata.dart';
// ignore: unused_import
import 'package:sepet_demo/View/Page/Auth/auth.dart';
// ignore: unused_import
import 'package:sepet_demo/View/Page/Auth/splash.dart';
// ignore: unused_import
import 'package:sepet_demo/View/Page/User/home.dart';

void main() {
  generateShop().whenComplete(() {
    fetchCategories().whenComplete(() {
      generateProduct().whenComplete(() {
        generateFlow().whenComplete(() {});
      });
    });
  });
  runApp(const AppStarter());
}

class AppStarter extends StatelessWidget {
  const AppStarter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeChanger(),
      child: Consumer<ThemeChanger>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Sepet',
            theme: value.isDark ? appDarkTheme : appLightTheme,
            themeMode: SchedulerBinding.instance!.window.platformBrightness ==
                    Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            // home: const AuthMainPage(),
            // home: const HomePage(),
          );
        },
      ),
    );
  }
}
