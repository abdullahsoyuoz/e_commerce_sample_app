// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({ Key? key }) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        title: const Text('BasketPage'),
      ),
      body: const Center(
        child: Text('BasketPage'),
      ),
    );
  }
}