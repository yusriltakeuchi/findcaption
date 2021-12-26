import 'package:findcaption/ui/constant/constant.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String? text;
  final String? clickText;
  final String? cancelText;
  final Function? onClickOK;
  final Function? onClickCancel;
  final String? title;
  final Widget? contentTextWidget;

  const InfoDialog({
    Key? key,
    required this.text,
    required this.onClickOK,
    this.onClickCancel,
    this.clickText = "OK",
    this.title,
    this.contentTextWidget,
    this.cancelText = "Batal",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
        child: Text(
          title!,
          style: styleTitle.copyWith(
            fontSize: setFontSize(55),
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          contentTextWidget == null
              ? Text(
                  text!,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: setFontSize(40),
                  ),
                )
              : contentTextWidget!,
          SizedBox(height: setHeight(60)),
          Row(
            children: <Widget>[
              onClickCancel != null
                  ? Expanded(
                      child: SizedBox(
                        width: deviceWidth,
                        height: setHeight(85),
                        child: OutlinedButton(
                          onPressed: () => onClickCancel!(),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                          child: Text(
                            cancelText!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: setFontSize(35),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              onClickCancel != null
                  ? const SizedBox(width: 10)
                  : const SizedBox(),
              Expanded(
                child: SizedBox(
                  width: deviceWidth,
                  height: setHeight(85),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () => onClickOK!(),
                    child: Text(
                      clickText!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: setFontSize(35),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
