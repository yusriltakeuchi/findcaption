import 'package:badges/badges.dart';
import 'package:findcaption/core/models/caption_model.dart';
import 'package:findcaption/core/utils/dialog/dialog_utils.dart';
import 'package:findcaption/core/utils/navigation/navigation_utils.dart';
import 'package:findcaption/core/viewmodels/caption/caption_provider.dart';
import 'package:findcaption/ui/constant/constant.dart';
import 'package:findcaption/ui/router/route_list.dart';
import 'package:findcaption/ui/widgets/components/buttons/primary_button.dart';
import 'package:findcaption/ui/widgets/components/caption/caption_item.dart';
import 'package:findcaption/ui/widgets/components/textfields/custom_textfield.dart';
import 'package:findcaption/ui/widgets/idle/idle_item.dart';
import 'package:findcaption/ui/widgets/idle/loading_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void pickLanguage() async {
    final captionProv = CaptionProvider.instance(context);
    if (captionProv.captionLanguages != null &&
        captionProv.captionLanguages!.isNotEmpty) {
      var result = await navigate.pushTo(
        routeHomePickLanguage,
        data: [
          captionProv.captionLanguages,
          captionProv.selectedCaptionLanguage
        ],
      );
      if (result != null) {
        captionProv.setSelectedCaptionLanguage(result);
        captionProv.clearCaptions();

        captionProv.getCaptions(
          captionProv.selectedCaptionLanguage!.code!,
          captionProv.currentYoutubeId!,
          captionProv.currentKeyword!,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Initialize screen utils
    setupScreenUtil(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Find Caption",
          style: styleTitle.copyWith(
            fontSize: setFontSize(45),
            color: Colors.white,
          ),
        ),
        actions: [
          Consumer<CaptionProvider>(
            builder: (context, captionProv, _) {
              return Padding(
                padding: EdgeInsets.only(right: setWidth(50)),
                child: GestureDetector(
                  onTap: () => pickLanguage(),
                  child: Badge(
                    position: BadgePosition.topEnd(top: 2, end: -8),
                    showBadge: captionProv.captionLanguages != null &&
                        captionProv.captionLanguages!.isNotEmpty,
                    badgeColor: Colors.green,
                    badgeContent: Text(
                      captionProv.captionLanguages != null
                          ? captionProv.captionLanguages!.length.toString()
                          : "0",
                      style: styleTitle.copyWith(color: Colors.white),
                    ),
                    child: const Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var youtubeUrlController = TextEditingController();
  var keywordController = TextEditingController();

  void goToPlay(int? startPosition) async {
    final captionProv = CaptionProvider.instance(context);
    await navigate.pushTo(
      routeVideoPlayer,
      data: [
        YoutubePlayer.convertUrlToId(youtubeUrlController.text),
        startPosition,
        captionProv.selectedCaptionLanguage?.code,
        isSmallPhoneHeight(context)
      ],
    );
    setupScreenUtil(context);
  }

  void searchCaption(String from) async {
    whenTypeKeyword(keywordController.text);
    whenTypeYoutubeUrl(youtubeUrlController.text);

    if (validYoutubeUrl && validKeyword) {
      final captionProv = CaptionProvider.instance(context);
      if (from == "empty") {
        captionProv.setSearchMode(true);

        /// Get video id from URL
        String? youtubeId =
            YoutubePlayer.convertUrlToId(youtubeUrlController.text);

        /// Find supported language
        await captionProv.getCaptionLanguages(youtubeId!);

        if (captionProv.captionLanguages!.isNotEmpty) {
          captionProv.setSelectedCaptionLanguage(
            captionProv.captionLanguages!.first,
          );
          captionProv.getCaptions(
            captionProv.selectedCaptionLanguage!.code!,
            youtubeId,
            keywordController.text,
          );
        }
      } else {
        captionProv.clearCaptions();

        /// Get video id from URL
        String? youtubeId =
            YoutubePlayer.convertUrlToId(youtubeUrlController.text);
        if (youtubeId != captionProv.currentYoutubeId) {
          /// Find supported language
          await captionProv.getCaptionLanguages(youtubeId!);
        }
        captionProv.getCaptions(
          captionProv.selectedCaptionLanguage!.code!,
          youtubeId!,
          keywordController.text,
        );
      }
    } else {
      DialogShow.showInfo(
        "This video does not contain a caption",
        "Caption Not Found",
        "OK",
      );
    }
  }

  bool validYoutubeUrl = true;
  void whenTypeYoutubeUrl(String value) {
    String patternUrl =
        r"^((http|https)\:\/\/)?((www|m)\.youtube\.com|youtu\.?be)\/((watch\?v=)?(.{11}))(&.*)*$";
    if (value.isEmpty) {
      if (validYoutubeUrl == true) {
        setState(() {
          validYoutubeUrl = false;
        });
      }
      return;
    } else {
      var regex = RegExp(patternUrl);
      if (regex.hasMatch(value)) {
        if (validYoutubeUrl == false) {
          setState(() {
            validYoutubeUrl = true;
          });
        }
      } else {
        if (validYoutubeUrl == true) {
          setState(() {
            validYoutubeUrl = false;
          });
        }
      }
    }
  }

  bool validKeyword = true;
  void whenTypeKeyword(String value) {
    if (value.isEmpty) {
      if (validKeyword == true) {
        setState(() {
          validKeyword = false;
        });
      }
      return;
    } else {
      if (value.length < 3) {
        if (validKeyword == true) {
          setState(() {
            validKeyword = false;
          });
        }
      } else {
        if (validKeyword == false) {
          setState(() {
            validKeyword = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CaptionProvider>(
      builder: (context, captionProv, _) {
        if (captionProv.searchCaptionMode == false) {
          return Center(
            child: SingleChildScrollView(
              child: _contentWidget(
                captionProv.searchCaptionMode,
                captionProv.captions,
              ),
            ),
          );
        }
        return _contentWidget(
          captionProv.searchCaptionMode,
          captionProv.captions,
        );
      },
    );
  }

  Widget _contentWidget(bool? searchCaptionMode, List<CaptionModel>? captions) {
    return Column(
      mainAxisAlignment: searchCaptionMode == true
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: searchCaptionMode == true
                ? [
                    BoxShadow(
                      color: blackColor.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: AnimatedCrossFade(
            firstChild: _contentEmptyWidget(),
            secondChild: _contentFilledWidget(),
            crossFadeState: searchCaptionMode == false
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          ),
        ),
        searchCaptionMode == true
            ? Expanded(
                child: SingleChildScrollView(
                  child: _captionListWidget(
                    captions,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  Widget _captionListWidget(List<CaptionModel>? captions) {
    if (captions == null) {
      return const LoadingListView();
    }
    if (captions.isEmpty) {
      return const IdleNoItemCenter(
        title: "Caption not found",
      );
    }

    final matchedCaptions = captions
        .where(
          (item) => item.text!.toLowerCase().contains(keywordController.text),
        )
        .toList();
    final similarCaptions = captions
        .where(
          (item) => !item.text!.toLowerCase().contains(keywordController.text),
        )
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: setHeight(40),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: setWidth(30),
          ),
          child: Text(
            "Matching Sentence:",
            style: styleTitle.copyWith(
              fontSize: setFontSize(45),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: matchedCaptions.length,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final caption = matchedCaptions[index];
            return CaptionItem(
              caption: caption,
              keyword: keywordController.text,
              onClickPlay: () => goToPlay(caption.startPosition),
            );
          },
        ),
        SizedBox(
          height: setHeight(20),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: setWidth(40),
          ),
          child: Text(
            "Similar:",
            style: styleTitle.copyWith(
              fontSize: setFontSize(45),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: similarCaptions.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final caption = similarCaptions[index];
            return CaptionItem(
              caption: similarCaptions[index],
              keyword: keywordController.text,
              onClickPlay: () => goToPlay(caption.startPosition),
            );
          },
        ),
      ],
    );
  }

  Widget _contentFilledWidget() {
    final node = FocusScope.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: setHeight(30),
        horizontal: setWidth(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _fieldYoutubeUrl(
            onEditComplete: () => node.nextFocus(),
          ),
          SizedBox(
            height: setHeight(20),
          ),
          _fieldKeyword(
            onEditComplete: () => node.nextFocus(),
          ),
          SizedBox(
            height: setHeight(40),
          ),
          _fieldSubmit("filled"),
        ],
      ),
    );
  }

  Widget _contentEmptyWidget() {
    final node = FocusScope.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setWidth(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: deviceWidth * 0.7,
            height: deviceHeight * 0.3,
            child: SvgPicture.asset("$imageAsset/find_illustration.svg"),
          ),
          _fieldYoutubeUrl(
            onEditComplete: () => node.nextFocus(),
          ),
          SizedBox(
            height: setHeight(20),
          ),
          _fieldKeyword(
            onEditComplete: () => node.nextFocus(),
          ),
          SizedBox(
            height: setHeight(40),
          ),
          _fieldSubmit("empty")
        ],
      ),
    );
  }

  Widget _fieldSubmit(String from) {
    return PrimaryButton(
      color: validKeyword && validKeyword ? primaryColor : grayColor,
      title: "Find Now",
      fontSize: 38,
      onClick: () => searchCaption(from),
    );
  }

  Widget _fieldYoutubeUrl({Function? onEditComplete}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          hintText: "Youtube URL (ex: https://www.youtube.com/watch?)",
          action: TextInputAction.next,
          type: TextInputType.text,
          controller: youtubeUrlController,
          hintColor: blackColor.withOpacity(0.5),
          useBoldText: false,
          fontSize: 38,
          onEditComplete: onEditComplete,
          onChange: (value) => whenTypeYoutubeUrl(value),
        ),
        validYoutubeUrl == false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: setHeight(10),
                  ),
                  Text(
                    "Youtube URL is not valid",
                    style: styleSubtitle.copyWith(
                      fontSize: setFontSize(30),
                      color: redColor,
                    ),
                  ),
                ],
              )
            : const SizedBox()
      ],
    );
  }

  Widget _fieldKeyword({Function? onEditComplete}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          hintText: "Keyword",
          action: TextInputAction.done,
          type: TextInputType.text,
          controller: keywordController,
          hintColor: blackColor.withOpacity(0.5),
          useBoldText: false,
          fontSize: 38,
          onEditComplete: onEditComplete,
          onChange: (value) => whenTypeKeyword(value),
        ),
        validKeyword == false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: setHeight(10),
                  ),
                  Text(
                    "Keywords minimum 3 characters",
                    style: styleSubtitle.copyWith(
                      fontSize: setFontSize(30),
                      color: redColor,
                    ),
                  ),
                ],
              )
            : const SizedBox()
      ],
    );
  }
}
