import 'package:findcaption/ui/constant/constant.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String? title;
  final Function? onClick;
  final double? fontSize;
  final bool? useBold;
  final bool? onlyRadiusBottom;
  final Widget? customChild;
  final double? padding;
  final bool? useFullWidth;
  final double? horizontalPadding;
  const PrimaryButton({
    Key? key,
    required this.color,
    required this.title,
    required this.onClick,
    this.textColor = Colors.white,
    this.fontSize = 45,
    this.useBold = true,
    this.onlyRadiusBottom = false,
    this.customChild,
    this.padding = 12,
    this.horizontalPadding = 0,
    this.useFullWidth = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: useFullWidth! ? deviceWidth : null,
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: color!.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(onlyRadiusBottom! ? 0 : 5),
          topRight: Radius.circular(onlyRadiusBottom! ? 0 : 5),
          bottomLeft: const Radius.circular(5),
          bottomRight: const Radius.circular(5),
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(onlyRadiusBottom! ? 0 : 5),
            topRight: Radius.circular(onlyRadiusBottom! ? 0 : 5),
            bottomLeft: const Radius.circular(5),
            bottomRight: const Radius.circular(5),
          ),
          onTap: () => onClick != null ? onClick!() : {},
          child: Padding(
            padding: EdgeInsets.all(padding!),
            child: Center(
              child: customChild ??
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding!,
                    ),
                    child: Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: useBold!
                          ? styleTitle.copyWith(
                              color: textColor,
                              fontSize: setFontSize(fontSize!),
                            )
                          : styleSubtitle.copyWith(
                              color: textColor,
                              fontSize: setFontSize(fontSize!),
                            ),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
