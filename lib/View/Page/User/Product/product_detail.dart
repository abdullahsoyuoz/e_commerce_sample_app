import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product data;
  const ProductDetailPage({Key? key, required this.data}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
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
      body: Center(
        child: Text(widget.data.title!.toString()),
      ),
    );
  }
}
