// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({ Key? key }) : super(key: key);

  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('MyListPage'),
      ),
      body: const Center(
        child: Text('MyListPage'),
      ),
    );
  }
}