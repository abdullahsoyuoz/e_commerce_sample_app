import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/Constant/constant.dart';
import 'package:sepet_demo/Controller/Provider/flows_provider.dart';
import 'package:sepet_demo/Controller/Provider/mylist_provider.dart';
import 'package:sepet_demo/Controller/Provider/theme_provider.dart';
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

void main() => run();

Future run() async {
  {
    generateShop().whenComplete(() {
      fetchCategories().whenComplete(() {
        fetchProduct().whenComplete(() {
          generateProduct().whenComplete(() {
            generateFlow().whenComplete(() async {
              await SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown
              ]);
            });
          });
        });
      });
    });
    runApp(
      const AppStarter(),
    );
  }
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
            // locale: Locale('en', 'US'),
            supportedLocales: supportedLanguages,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: value.isDark()! ? appDarkTheme : appLightTheme,
            themeMode: SchedulerBinding.instance.window.platformBrightness ==
                    Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: StatusBarManager(
              translucent: true,
              statusBarColor: Colors.transparent,
              child: ScrollConfiguration(
                behavior: WithoutGlowBehavior(),
                child: const SplashScreen(),
                // child: const AuthMainPage(),
              ),
            ),
            // home: const HomePage(),
          );
        },
      ),
    );
  }
}
