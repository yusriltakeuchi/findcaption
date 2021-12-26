import 'package:findcaption/ui/constant/constant.dart';
import 'package:findcaption/ui/widgets/components/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class IdleLoadingCenter extends StatelessWidget {
  final Color? color;
  const IdleLoadingCenter({
    Key? key,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth,
      height: deviceHeight,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: color,
        ),
      ),
    );
  }
}

class IdleNoItemCenter extends StatelessWidget {
  final String? title;
  final Color? color;
  final bool? useDeviceHeight;
  final String? iconPathSVG;
  final VoidCallback? onClickLogout;
  final VoidCallback? onClickRetry;
  const IdleNoItemCenter({
    Key? key,
    required this.title,
    this.color,
    this.useDeviceHeight = true,
    this.iconPathSVG,
    this.onClickLogout,
    this.onClickRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth,
      height: useDeviceHeight! ? deviceHeight / 2 : null,
      child: iconPathSVG == null
          ? Center(
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: styleTitle.copyWith(
                  color: color ?? blackColor,
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  iconPathSVG!,
                  width: setWidth(deviceWidth),
                  height: setHeight(600),
                ),
                const SizedBox(height: 10),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: styleTitle.copyWith(color: color ?? blackColor),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    onClickLogout != null
                        ? FittedBox(
                            child: PrimaryButton(
                              color: redColor,
                              title: "Keluar",
                              padding: 10,
                              horizontalPadding: 10,
                              fontSize: 40,
                              useFullWidth: false,
                              onClick: () => onClickLogout!(),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: setWidth(
                        onClickLogout != null && onClickRetry != null ? 20 : 0,
                      ),
                    ),
                    onClickRetry != null
                        ? FittedBox(
                            child: PrimaryButton(
                              color: primaryColor,
                              title: "Refresh",
                              padding: 10,
                              horizontalPadding: 10,
                              fontSize: 40,
                              useFullWidth: false,
                              onClick: () => onClickRetry!(),
                            ),
                          )
                        : const SizedBox(),
                  ],
                )
              ],
            ),
    );
  }
}
