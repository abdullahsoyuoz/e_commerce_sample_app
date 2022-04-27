import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

// ignore: must_be_immutable
class BestsellerWidget extends StatelessWidget {
  late int index;
  final Product? data;

  BestsellerWidget({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 70,
          minHeight: 70,
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  data!.photosUrl![0],
                  fit: BoxFit.cover,
                  width: 70,
                  height: 70,
                  loadingBuilder: (context, child, loading) =>
                      loadingIndicator(context, child, loading),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 15,
                            maxHeight: 15,
                            maxWidth: 15,
                            minWidth: 15,
                          ),
                          child: const FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 20,
                          maxHeight: 20,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            data!.rank!.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 15,
                            maxHeight: 15,
                            maxWidth: 15,
                            minWidth: 15,
                          ),
                          child: const FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.solidUser,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 20,
                          maxHeight: 20,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            NumberFormat.compact(locale: 'en_US')
                                .format(data!.purchasesCount!),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 15,
                            maxHeight: 15,
                            maxWidth: 15,
                            minWidth: 15,
                          ),
                          child: const FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.solidCommentDots,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 20,
                          maxHeight: 20,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            NumberFormat.compact(locale: 'en_US')
                                .format(data!.commentCount!),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BestSellerPersisten extends SliverPersistentHeaderDelegate {
  final Widget child;
  BestSellerPersisten(this.child);

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
