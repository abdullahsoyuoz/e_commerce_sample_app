// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:animate_do/animate_do.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/Provider/mylist_provider.dart';
import 'package:sepet_demo/Model/mylist.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Style/input_decorations.dart';
import 'package:sepet_demo/View/View/Picker/color_picker.dart';
// import 'package:sepet_demo/View/View/Picker/icon_picker.dart';

Future<void> showFlexibleBookmarkSheet(
    BuildContext context, Product? data) async {
  showFlexibleBottomSheet<void>(
    context: context,
    minHeight: 0,
    initHeight: 0.5,
    maxHeight: 1,
    anchors: [0, 0.5, 1],
    isExpand: true,
    isSafeArea: true,
    keyboardBarrierColor: Colors.transparent,
    bottomSheetColor: Colors.transparent,
    builder: (context, controller, offset) {
      return _BookmarkSheet(
        scrollController: controller,
        bottomSheetOffset: offset,
        productData: data,
      );
    },
  );
}

class _BookmarkSheet extends StatefulWidget {
  final ScrollController? scrollController;
  final double? bottomSheetOffset;
  final Product? productData;

  const _BookmarkSheet({
    this.scrollController,
     this.bottomSheetOffset,
    Key? key,
     this.productData,
  }) : super(key: key);

  @override
  State<_BookmarkSheet> createState() => _BookmarkSheetState();
}

class _BookmarkSheetState extends State<_BookmarkSheet> {
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
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: appRadius(),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          controller: widget.scrollController,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 10,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    languageConverter(context, "myList")!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 17,),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () =>
                              showFlexibleNewBookmarkSheet(context),
                          icon: LineIcon(LineIcons.plus)),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: LineIcon(LineIcons.times)),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              height: 0,
            ),
            Consumer<MyListsProvider>(builder: (context, value, _) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getList()!.length,
                itemBuilder: (context, index) {
                  final data = value.getList()![index];
                  return ListItem(
                      data: data,
                      index: index,
                      productData: widget.productData);
                },
                separatorBuilder: (_, i) => const Divider(
                  thickness: 0.25,
                  height: 0,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  final MyList? data;
  final int? index;
  final Product? productData;
  const ListItem({
    Key? key,
     this.data,
     this.index,
     this.productData,
  }) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem>
    with SingleTickerProviderStateMixin {
   late AnimationController _bookmarkAnimationController;

  @override
  void initState() {
    _bookmarkAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      _bookmarkAnimationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyListsProvider>(builder: (context, provider, _) {
      return Slidable(
        key: LabeledGlobalKey(widget.data!.products.hashCode.toString()),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                if (!widget.data!.isConst) {
                  provider.removeList(widget.index);
                }
              },
              autoClose: true,
              backgroundColor: AppColors.red,
              flex: 1,
              icon: LineIcons.trash,
              foregroundColor: Colors.white,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            widget.data!.isConst ? languageConverter(context, widget.data!.title)! + ' (${widget.data!.products!.length})' : widget.data!.title! + ' (${widget.data!.products!.length})',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          leading: widget.data!.iconData != null
              ? LineIcon(
                  widget.data!.iconData!,
                  color: widget.data!.color ?? Theme.of(context).iconTheme.color,
                )
              : const SizedBox(),
          trailing: IconButton(
            icon: Bounce(
              manualTrigger: true,
              animate: false,
              key: LabeledGlobalKey(widget.data.hashCode.toString()),
              from: 30,
              controller: (p0) {
                _bookmarkAnimationController = p0;
              },
              child: LineIcon(
                LineIcons.bookmark,
                // ignore: iterable_contains_unrelated_type
                color: provider.myList![widget.index!].products == null
                    ? Theme.of(context).iconTheme.color
                    : !provider.myList![widget.index!].products!
                            .contains(widget.productData)
                        ? Theme.of(context).iconTheme.color
                        : AppColors.orange,
              ),
            ),
            onPressed: () {
              if (provider.myList![widget.index!].products == null) {
                provider
                    .addItem(widget.productData, widget.index!)
                    .whenComplete(() {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _bookmarkAnimationController.forward().whenComplete(() {
                      _bookmarkAnimationController.reset();
                    });
                  });
                });
              }
              if (provider.myList![widget.index!].products!
                  .contains(widget.productData)) {
                provider.removeItem(widget.productData, widget.index!);
              } else {
                provider
                    .addItem(widget.productData, widget.index!)
                    .whenComplete(() {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _bookmarkAnimationController.forward().whenComplete(() {
                      _bookmarkAnimationController.reset();
                    });
                  });
                });
              }
            },
          ),
        ),
      );
    });
  }
}

void showFlexibleNewBookmarkSheet(BuildContext context) {
  showFlexibleBottomSheet<void>(
    minHeight: 0,
    initHeight: 0.5,
    maxHeight: 1,
    anchors: [0, 0.5, 1],
    context: context,
    isExpand: true,
    isSafeArea: true,
    keyboardBarrierColor: Colors.transparent,
    bottomSheetColor: Colors.transparent,
    builder: (context, controller, offset) {
      return _NewBookmarkSheet(
        scrollController: controller,
        bottomSheetOffset: offset,
      );
    },
  );
}

class _NewBookmarkSheet extends StatefulWidget {
  final ScrollController? scrollController;
  final double? bottomSheetOffset;

  const _NewBookmarkSheet({
     this.scrollController,
     this.bottomSheetOffset,
    Key? key,
  }) : super(key: key);

  @override
  State<_NewBookmarkSheet> createState() => _NewBookmarkSheetState();
}

class _NewBookmarkSheetState extends State<_NewBookmarkSheet> {
  final TextEditingController _title = TextEditingController();
  IconData? pickedIconData;
  Color? pickedColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyListsProvider>(builder: (context, value, _) {
      return SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: appRadius(),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            controller: widget.scrollController,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 10,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageConverter(context, "newList")!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 17),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_title.text.isNotEmpty && _title.text != '') {
                              value.addList(MyList(
                                title: _title.text,
                                color: pickedColor ?? Colors.black,
                                iconData: pickedIconData,
                                isConst: false,
                                products: [],
                              ));
                            }
                            Navigator.pop(context);
                          },
                          icon: LineIcon(LineIcons.check),
                        ),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: LineIcon(LineIcons.times)),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    pickedIconData == null
                        ? LineIcon(
                            LineIcons.questionCircle,
                            size: 40,
                          )
                        : LineIcon(
                            pickedIconData!,
                            size: 40,
                            color: pickedColor ??
                                Theme.of(context).iconTheme.color,
                          ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: _title,
                          style: TextStyle(
                              color: Theme.of(context).iconTheme.color),
                          decoration: getSearchInputDecoration(
                              context, languageConverter(context, "listName")),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            // iconPicker(context).then((value) {
                            //   pickedIconData = value;
                            // }).whenComplete(() {
                            //   setState(() {});
                            // });
                          },
                          child: Text(languageConverter(context, "listIcon")!)),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: OutlinedButton(
                            onPressed: () {
                              colorPickerDialog(context).then((color) {
                                pickedColor = color;
                              }).whenComplete(() {
                                setState(() {});
                              });
                            },
                            child: Text(languageConverter(context, "listColor")!)),
                      )
                    ],
                  )),
            ],
          ),
        ),
      );
    });
  }
}
