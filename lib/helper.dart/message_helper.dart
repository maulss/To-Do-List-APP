import 'package:flutter/material.dart';

import 'package:todo_app/constants/color_constant.dart';
import 'package:todo_app/constants/text_style_constant.dart';

void displaMessageUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      alignment: Alignment.center,
      backgroundColor: ColorConstant.backgroundColor,
      title: Text(
        message,
        style: TextStyleConstant.lato
            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Oke",
            style: TextStyleConstant.lato,
          ),
        )
      ],
    ),
  );
}
