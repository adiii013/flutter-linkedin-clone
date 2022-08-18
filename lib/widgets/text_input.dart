import 'package:flutter/material.dart';

class TextInputBox extends StatelessWidget {
  TextEditingController textController = TextEditingController();
  final String hintText;
 TextInputBox({Key? key,required this.textController, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(hintText: hintText, labelText: hintText),
      ),
    );
  }
}
