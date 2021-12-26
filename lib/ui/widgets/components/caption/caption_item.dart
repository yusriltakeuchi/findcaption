import 'package:findcaption/ui/constant/constant.dart';
import 'package:findcaption/ui/widgets/components/buttons/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:findcaption/core/models/caption_model.dart';

class CaptionItem extends StatelessWidget {
  final CaptionModel? caption;
  const CaptionItem({
    Key? key,
    required this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: setWidth(30),
        ),
        child: Column(
          children: [
            SizedBox(
              height: setHeight(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.language,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: setWidth(20),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              caption!.text!,
                              style: styleTitle.copyWith(
                                color: blackColor,
                                fontSize: setFontSize(40),
                              ),
                            ),
                            Text(
                              "From minute ${caption?.startPosition}",
                              style: styleSubtitle.copyWith(
                                color: blackColor,
                                fontSize: setFontSize(35),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: setWidth(20),
                ),
                FittedBox(
                  child: PrimaryButton(
                    color: primaryColor,
                    useFullWidth: false,
                    padding: 6,
                    title: "PLAY",
                    horizontalPadding: 5,
                    fontSize: 34,
                    onClick: () {},
                  ),
                )
              ],
            ),
            SizedBox(
              height: setHeight(25),
            ),
            Divider(
              height: 0,
              color: blackColor,
            )
          ],
        ),
      ),
    );
  }
}
