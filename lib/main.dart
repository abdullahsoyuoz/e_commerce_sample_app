import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/Provider/flows_provider.dart';
import 'package:sepet_demo/Controller/Provider/mylist_provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/Model/Dummy/flows.dart';
import 'package:sepet_demo/Model/Dummy/products.dart';
// ignore: unused_import
import 'package:sepet_demo/View/Page/Auth/auth.dart';
// ignore: unused_import
import 'package:sepet_demo/View/Page/Auth/splash.dart';
// ignore: unused_import
import 'package:sepet_demo/View/Page/User/home.dart';
import 'package:sepet_demo/View/Style/Theme/dark.dart';
import 'package:sepet_demo/View/Style/Theme/light.dart';
import 'package:sepet_demo/View/Style/scroll_behavior.dart';
import 'package:statusbarmanager/statusbarmanager.dart';

void main() {
  generateShop().whenComplete(() {
    fetchCategories().whenComplete(() {
      generateProduct().whenComplete(() {
        generateFlow().whenComplete(() {});
      });
    });
  });
  runApp(
    StatusBarManager(
      translucent: true,
      child: const AppStarter(),
      statusBarColor: Colors.transparent,
    ),
  );
}

class AppStarter extends StatefulWidget {
  const AppStarter({Key? key}) : super(key: key);

  // void setStatus() async {
  //   await StatusBarControl.setTranslucent(true);
  // }

  @override
  State<AppStarter> createState() => _AppStarterState();
}

class _AppStarterState extends State<AppStarter> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeChanger>(
          create: (context) => ThemeChanger(),
        ),
        ChangeNotifierProvider<MyListsProvider>(
          create: (context) => MyListsProvider(),
        ),
        ChangeNotifierProvider<FlowsProvider>(
          create: (context) => FlowsProvider(),
        ),
      ],
      child: Consumer<ThemeChanger>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Sepet',
            theme: value.isDark() ? appDarkTheme : appLightTheme,
            themeMode: SchedulerBinding.instance!.window.platformBrightness ==
                    Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: ScrollConfiguration(
              behavior: WithoutGlowBehavior(),
              // child: const SplashScreen(),
              child: const AuthMainPage(),
            ),
            // home: const HomePage(),
          );
        },
      ),
    );
  }
}
