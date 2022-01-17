import 'package:findcaption/core/utils/navigation/navigation_utils.dart';
import 'package:findcaption/ui/constant/constant.dart';
import 'package:flutter/material.dart';

import 'package:findcaption/core/models/caption_language_model.dart';

class HomePickLanguageScreen extends StatelessWidget {
  final List<CaptionLanguageModel>? languages;
  final CaptionLanguageModel? selectedLanguage;
  const HomePickLanguageScreen({
    Key? key,
    required this.languages,
    required this.selectedLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => navigate.pop(),
        ),
        title: Text(
          "Select Language",
          style: styleTitle.copyWith(
            fontSize: setFontSize(45),
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: languages!.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final lang = languages?[index];
          return _languageItem(
            lang,
            onClick: () {
              navigate.pop(data: lang);
            },
            selected: selectedLanguage != null
                ? lang?.code == selectedLanguage?.code
                : false,
          );
        },
      ),
    );
  }

  Widget _languageItem(
    CaptionLanguageModel? lang, {
    VoidCallback? onClick,
    bool selected = false,
  }) {
    return InkWell(
      onTap: () => onClick!(),
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
                              lang!.name!,
                              style: styleTitle.copyWith(
                                color: blackColor,
                                fontSize: setFontSize(40),
                              ),
                            ),
                            Text(
                              "Language Code: ${lang.code}",
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
                Icon(
                  selected == true
                      ? Icons.check_circle
                      : Icons.keyboard_arrow_right,
                  color: selected == true ? greenColor : blackColor,
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
