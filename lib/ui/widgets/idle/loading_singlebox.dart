import 'package:flutter/material.dart';

import 'package:findcaption/ui/constant/constant.dart';

class LoadingSingleBox extends StatelessWidget {
  final double height;
  const LoadingSingleBox({
    Key? key,
    this.height = 150,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth,
      height: setHeight(height),
      color: grayColor.withOpacity(0.3),
    );
  }
}