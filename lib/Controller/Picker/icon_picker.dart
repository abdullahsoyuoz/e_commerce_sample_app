import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

Future<IconData?> iconPicker(BuildContext context) async {
  IconData? _iconData;
  await FlutterIconPicker.showIconPicker(
    context,
    iconPackModes: [
      IconPack.cupertino,
      IconPack.fontAwesomeIcons,
      IconPack.lineAwesomeIcons,
      IconPack.material,
    ],
    // adaptiveDialog: true,
    iconColor: Theme.of(context).iconTheme.color,
    closeChild: OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('İptal')),
    showTooltips: true,
    searchHintText: 'Icon ara',
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Row(
      children: [
        LineIcon(LineIcons.laughingWinkingFace),
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Text(
            'icon seçelim?',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).iconTheme.color),
          ),
        )
      ],
    ),
  ).then((value) {
    if (value != null) {
      _iconData = value;
    }
  });
  return _iconData;
}
