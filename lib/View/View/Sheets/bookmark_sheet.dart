import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Controller/Picker/color_picker.dart';
import 'package:sepet_demo/Controller/Picker/icon_picker.dart';
import 'package:sepet_demo/Model/Dummy/mylists.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Style/input_decorations.dart';

Future<void> showFlexibleBookmarkSheet(BuildContext context) async {
  showFlexibleBottomSheet<void>(
    minHeight: 0,
    initHeight: 0.6,
    maxHeight: 0.9,
    context: context,
    isExpand: true,
    duration: const Duration(milliseconds: 300),
    isSafeArea: false,
    keyboardBarrierColor: Colors.transparent,
    bottomSheetColor: Colors.transparent,
    builder: (context, controller, offset) {
      return _BookmarkSheet(
        scrollController: controller,
        bottomSheetOffset: offset,
      );
    },
    anchors: [0, 0.3, 0.9],
  );
}

class _BookmarkSheet extends StatelessWidget {
  final ScrollController scrollController;
  final double bottomSheetOffset;

  const _BookmarkSheet({
    required this.scrollController,
    required this.bottomSheetOffset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: appRadius(context),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          controller: scrollController,
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
                    'Listelerin',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 17),
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
            const Divider(),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: myLists.length,
              itemBuilder: (context, index) {
                final data = myLists[index];
                return ListTile(
                  title: Text(
                    data.title!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  leading: data.iconData != null
                      ? LineIcon(data.iconData!)
                      : const SizedBox(),
                  trailing: IconButton(
                    icon: LineIcon(LineIcons.bookmark),
                    onPressed: () {},
                  ),
                );
              },
              separatorBuilder: (_, i) => const Divider(
                thickness: 0.25,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showFlexibleNewBookmarkSheet(BuildContext context) {
  showFlexibleBottomSheet<void>(
    minHeight: 0,
    initHeight: 0.6,
    maxHeight: 0.9,
    context: context,
    isExpand: true,
    isSafeArea: false,
    keyboardBarrierColor: Colors.transparent,
    bottomSheetColor: Colors.transparent,
    builder: (context, controller, offset) {
      return _NewBookmarkSheet(
        scrollController: controller,
        bottomSheetOffset: offset,
      );
    },
    anchors: [0, 0.3, 0.9],
  );
}

class _NewBookmarkSheet extends StatefulWidget {
  final ScrollController scrollController;
  final double bottomSheetOffset;

  const _NewBookmarkSheet({
    required this.scrollController,
    required this.bottomSheetOffset,
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
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(
            top: appRadius(context).topLeft,
          ),
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
                    'Yeni liste oluştur',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 17),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: LineIcon(LineIcons.check)),
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
                  LineIcon(
                    LineIcons.edit,
                    size: 40,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: _title,
                        decoration: getSearchInputDecoration(
                            context, 'listenin ismi ?'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    pickedIconData == null
                        ? LineIcon(
                            LineIcons.icons,
                            size: 40,
                          )
                        : LineIcon(
                            pickedIconData!,
                            size: 40,
                            color: pickedColor ??
                                Theme.of(context).iconTheme.color,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: OutlinedButton(
                          onPressed: () {
                            iconPicker(context).then((value) {
                              pickedIconData = value;
                            }).whenComplete(() {
                              setState(() {});
                            });
                          },
                          child: const Text('ikon seç')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: OutlinedButton(
                          onPressed: () {
                            colorPickerDialog(context).then((color) {
                              pickedColor = color!;
                            }).whenComplete(() {
                              setState(() {});
                            });
                          },
                          child: const Text('renk seç')),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
