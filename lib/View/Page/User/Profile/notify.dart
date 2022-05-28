import 'package:flutter/material.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({ Key key }) : super(key: key);

  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> with SingleTickerProviderStateMixin {
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
        title: const Text('NotifyPage'),
      ),
      body: const Center(
        child: Text('NotifyPage'),
      ),
    );
  }
}