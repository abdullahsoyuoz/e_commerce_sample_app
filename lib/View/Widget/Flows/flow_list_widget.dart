// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Widget/Flows/flow_products_view.dart';
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
    var _dark = Provider.of<ThemeChanger>(context, listen: false).isDark;
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
            _dark
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox.expand(
                      child: ColoredBox(color: widget.data.color!.shade200),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(
                widget.data.imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingIndicator(context, child, loadingProgress),
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
                        widget.data.title!.toUpperCase(),
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
