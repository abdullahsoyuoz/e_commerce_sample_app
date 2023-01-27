// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({ Key? key }) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> with SingleTickerProviderStateMixin {
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
        title: const Text('MessagesPage'),
      ),
      body: const Center(
        child: Text('MessagesPage'),
      ),
    );
  }
}