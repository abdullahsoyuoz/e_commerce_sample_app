// ignore_for_file: unnecessary_null_comparison

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';

Future<Color?> colorPickerDialog(BuildContext context) async {
  Color? pickedColor;
  await ColorPicker(
    // Use the dialogPickerColor as start color.
    color: Theme.of(context).scaffoldBackgroundColor,
    // Update the dialogPickerColor using the callback.
    onColorChanged: (Color color) {
      if (color == null) {
        pickedColor = Colors.white;
      }
      pickedColor = color;
    },

    width: 40,
    height: 40,
    borderRadius: 10,
    spacing: 15,
    runSpacing: 10,
    columnSpacing: 10,
    showMaterialName: false,
    showColorValue: false,
    showRecentColors: false,
    showColorName: true,
    showColorCode: true,
    copyPasteBehavior: const ColorPickerCopyPasteBehavior(
      longPressMenu: false,
    ),
    heading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        LineIcon(LineIcons.grinningFaceWithSmilingEyes),
        Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Text(
              languageConverter(context, "colorSheetTitle")!,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).iconTheme.color),
            ),
          )
      ],),
    ),
    subheading: Text(
      languageConverter(context, "colorTone")!,
      style: Theme.of(context)
          .textTheme
          .caption!.copyWith(color: Theme.of(context).iconTheme.color),
    ),
    padding: const EdgeInsets.all(5),
    actionButtons: ColorPickerActionButtons(
      dialogCancelButtonLabel: languageConverter(context, "cancel"),
      dialogOkButtonLabel: languageConverter(context, "select"),
      dialogOkButtonType: ColorPickerActionButtonType.outlined,
      dialogCancelButtonType: ColorPickerActionButtonType.outlined,
    ),
    materialNameTextStyle: Theme.of(context)
        .textTheme
        .caption!
        .copyWith(color: Theme.of(context).iconTheme.color),
    colorNameTextStyle: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).iconTheme.color),
    colorCodeTextStyle: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).iconTheme.color),
    pickersEnabled: const <ColorPickerType, bool>{
      ColorPickerType.both: false,
      ColorPickerType.primary: true,
      ColorPickerType.accent: false,
      ColorPickerType.bw: false,
      ColorPickerType.custom: false,
      ColorPickerType.wheel: false,
    },
  )
      .showPickerDialog(
        context,
        constraints:
            const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor
      )
      .then((boole) {});
  return pickedColor;
}
