import 'package:findcaption/ui/constant/constant.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String? text;

  const LoadingDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
      content: Text(
        text!,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black87,
          fontSize: setFontSize(40),
        ),
      ),
    );
  }
}
