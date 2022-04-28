import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Style/input_decorations.dart';
import 'package:sepet_demo/View/Widget/rectangle_container.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _searchController;
  late FocusNode _searchNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchNode = FocusNode();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _searchNode.requestFocus();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: RectangleContainer(
          child: SizedBox(
            width: context.width * 0.6,
            child: TextField(
                controller: _searchController,
                focusNode: _searchNode,
                cursorColor: Theme.of(context).iconTheme.color,
                style: const TextStyle().copyWith(color: Colors.white),
                decoration: getSearchInputDecoration(context, 'aramaya başla')),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Sonuçları sırala veya filtrele',
            icon: const FaIcon(FontAwesomeIcons.sliders),
          ),
        ],
      ),
      body: const Center(
        child: Text('SearchPage'),
      ),
    );
  }
}
