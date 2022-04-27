// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/View/flow_products_view.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

class FlowListWidget extends StatefulWidget {
  FlowEntity data;
  FlowListWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<FlowListWidget> createState() => _FlowListWidgetState();
}

class _FlowListWidgetState extends State<FlowListWidget> {
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
    return BouncingWidget(
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => FlowListProductsView(
              data: widget.data,
            ),
          ),
        );
      },
      child: SizedBox(
        width: context.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: appRadius(context),
                child: Image.network(
                  widget.data.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (c,o,s) => errorIndicator(c, o, s??StackTrace.empty),
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingIndicator(context, child, loadingProgress),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        widget.data.title!.toUpperCase().addWhitespace,
                        style: Theme.of(context).textTheme.subtitle2!,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
