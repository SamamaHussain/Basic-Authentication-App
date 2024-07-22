import 'package:flutter/material.dart';

Future<void> showdialogue(
  BuildContext context, String content) async {
return showDialog<void>(
  context: context, builder: (context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        )
      ],
    );

  },
);
}