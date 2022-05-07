import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/Constant/constant.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/Model/category.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/logo.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController _scrollController;
  late final AnimationController _animationController;
  // DUMMY
  bool notify = true;

  @override
  void initState() {
    _scrollController = ScrollController();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Scaffold(
            key: _scaffoldKey,
            body: SizedBox.expand(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                        top: 70 + context.padding.top, bottom: 100),
                    children: [
                      _slideAnimate(
                        Direction.LEFT,
                        const TitleWidget(title: 'Kategoriler'),
                      ),
                      _slideAnimate(
                        Direction.RIGHT,
                        _buildCategories(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: _slideAnimate(
                          Direction.LEFT,
                          const TitleWidget(title: 'Ayarlar'),
                        ),
                      ),
                      _slideAnimate(
                        Direction.RIGHT,
                        _buildSettings(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: _slideAnimate(
                          Direction.LEFT,
                          const TitleWidget(title: 'Destek ve Bilgi'),
                        ),
                      ),
                      _slideAnimate(
                        Direction.RIGHT,
                        _buildSupport(),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: _slideAnimate(Direction.UP, _navAppBar()),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _navAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3,
            sigmaY: 3,
          ),
          child: SizedBox(
            height: 70 + context.padding.top,
            child: AppBar(
              toolbarHeight: 70,
              centerTitle: false,
              elevation: 0,
              backgroundColor: Theme.of(context)
                  .appBarTheme
                  .backgroundColor!
                  .withOpacity(0.1),
              automaticallyImplyLeading: false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: LineIcon(
                      LineIcons.arrowLeft,
                      color: Theme.of(context).iconTheme.color!,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                      'combin',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.lato(fontSize: 30, height: 0.8),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LogoWidget(size: 50, color: Theme.of(context).iconTheme.color,),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      width: context.width,
      height: context.width * 0.75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        padding: const EdgeInsets.only(left: 30),
        physics: const BouncingScrollPhysics(),
        itemCount: categoryList.length,
        itemBuilder: (_, index) {
          final data = categoryList[index];
          return buildCategoryItem(data);
        },
      ),
    );
  }

  Widget buildCategoryItem(Category data) {
    return AspectRatio(
      aspectRatio: 0.6,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BouncingWidget(
              onPressed: () {},
              child: Card(
                child: ClipRRect(
                  borderRadius: appRadius(),
                  child: Image.asset(
                    'assets/image/categories/${data.categoryId}${data.id}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(
                color: data.color,
                thickness: 1,
              ),
            ),
            Flexible(
              child: Text(
                data.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettings() {
    return AspectRatio(
      aspectRatio: 3,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 30),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BouncingWidget(
                    onPressed: () {
                      Provider.of<ThemeChanger>(context, listen: false)
                          .toggle();
                    },
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Card(
                        color: Theme.of(context).iconTheme.color,
                        child: Center(
                          child: LineIcon(
                            Provider.of<ThemeChanger>(context, listen: false)
                                    .isDark()
                                ? LineIcons.sun
                                : LineIcons.moon,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Tema',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
          buildSettingsItem(
            'Bildirimler',
            LineIcons.bell
          ),
          buildSettingsItem(
            'Profili düzenle',
            LineIcons.user
          ),
        ],
      ),
    );
  }

  Padding buildSettingsItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BouncingWidget(
              onPressed: () {},
              child: AspectRatio(
                aspectRatio: 1,
                child: Card(
                  child: Center(
                    child: LineIcon(icon),
                  )
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              title,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupport() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        buildSupportItem('Bize ulaşın', LineIcons.headset),
        buildSupportItem('Sipariş yardım', LineIcons.truckLoading),
        buildSupportItem('Değerlendirmelerim', LineIcons.certificate),
        buildSupportItem('Geri Bildirim', LineIcons.grinningFace),
        buildSupportItem('Kişisel verilerin korunması', LineIcons.fileContract),
        buildSupportItem('Hakkımızda', LineIcons.identificationBadge),
      ],
    );
  }

  Widget buildSupportItem(String title, IconData icon, {int? index}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: BouncingWidget(
              onPressed: () {},
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: LineIcon(icon),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 13,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //

  Widget _slideAnimate(Direction direction, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
              begin: direction == Direction.LEFT
                  ? const Offset(-0.75, 0)
                  : direction == Direction.RIGHT
                      ? const Offset(0.75, 0)
                      : direction == Direction.UP
                          ? const Offset(0, -0.75)
                          : const Offset(0, 0.75),
              end: Offset.zero)
          .animate(CurvedAnimation(
              parent: _animationController, curve: Curves.ease)),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _animationController.value,
        child: child,
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 25),
      ),
    );
  }
}
