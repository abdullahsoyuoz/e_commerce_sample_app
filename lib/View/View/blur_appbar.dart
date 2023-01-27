import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';

PreferredSizeWidget blurAppBar(BuildContext context, {Widget? title, Widget? leading, List<Widget>? action}){
  return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15,
            sigmaY: 15,
          ),
          child: SizedBox(
            width: context.width,
            height: 70 + context.padding.top,
            child: AppBar(
              toolbarHeight: 70,
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: title,
              leading: leading,
              actions: action,
            ),
          ),
        ),
      ),
    );
}