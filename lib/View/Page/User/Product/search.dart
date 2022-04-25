import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/input_decorations.dart';

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
        backgroundColor: AppColors.purple,
        title: SizedBox(
          width: context.width * 0.5,
          child: TextField(
            controller: _searchController,
            focusNode: _searchNode,
            textAlign: TextAlign.center,
            style: const TextStyle().copyWith(color: Colors.white),
            decoration: getSearchInputDecoration('aramaya başla')
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('SearchPage'),
      ),
    );
  }
}
