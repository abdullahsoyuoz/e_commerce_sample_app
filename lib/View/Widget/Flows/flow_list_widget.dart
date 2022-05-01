import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/View/flow_products_view.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

class FlowListWidget extends StatefulWidget {
  final FlowEntity data;
  const FlowListWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<FlowListWidget> createState() => _FlowListWidgetState();
}

class _FlowListWidgetState extends State<FlowListWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.ease,
              reverseCurve: Curves.ease,
            ),
          ),
          child: child,
        );
      },
      child: BouncingWidget(
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: widget.data.color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: appRadius(context),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.data.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (c, o, s) =>
                            errorIndicator(c, o, s ?? StackTrace.empty),
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingIndicator(context, child, loadingProgress),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: context.width,
                          color: Theme.of(context).iconTheme.color,
                          child: Text(
                            widget.data.title!.toUpperCase().addWhitespace,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).backgroundColor),
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomLeft,
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Expanded(
              //           child: Text(
              //             widget.data.title!.toUpperCase().addWhitespace,
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .subtitle2!
              //                 .copyWith(fontWeight: FontWeight.w600),
              //             maxLines: 3,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
