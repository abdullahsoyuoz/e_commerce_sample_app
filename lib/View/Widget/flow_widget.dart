import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:flutter/cupertino.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Page/User/Product/flow_products_list_page.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

class FlowWidget extends StatefulWidget {
  final FlowEntity data;
  const FlowWidget({Key key, this.data}) : super(key: key);

  @override
  State<FlowWidget> createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget>
    with SingleTickerProviderStateMixin {
   AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
    return AnimatedBuilder(
      // animation: _animationController,
      animation: CurvedAnimation(
          parent: _animationController, curve: Curves.easeOutCirc),
      builder: (context, child) {
        // SLIDE
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(-0.25, 0), end: Offset.zero)
              .animate(_animationController),
          child: child,
        );
        // // // SCALE
        // return ScaleTransition(
        //   scale: Tween<double>(begin: 0.75, end: 1).animate(_animationController),
        //   alignment: Alignment.bottomCenter,
        //   filterQuality: FilterQuality.low,
        //   child: child,
        // );
        // // NOT
        // return SizedBox(child: child);
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
            BouncingWidget(
              onPressed: () {
                if (widget.data.targetProducts != null) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => FlowProductsListPage(
                        data: widget.data,
                      ),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 0,
                  child: ClipRRect(
                    borderRadius: appRadius(),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          widget.data.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (c, o, s) =>
                              errorIndicator(c, o, s ?? StackTrace.empty),
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingIndicator(context, child, loadingProgress),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: context.width,
                            color: Theme.of(context).iconTheme.color,
                            padding: EdgeInsets.symmetric(
                              horizontal: appPaddingForRadius(),
                              vertical: 2,
                            ),
                            child: Text(
                              widget.data.title.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
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
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Tooltip(
                  message: languageConverter(context, widget.data.typeString),
                  triggerMode: TooltipTriggerMode.tap,
                  child: CircleAvatar(
                    backgroundColor: widget.data.color.withOpacity(.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
