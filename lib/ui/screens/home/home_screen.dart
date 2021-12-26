import 'package:findcaption/ui/constant/constant.dart';
import 'package:findcaption/ui/widgets/components/buttons/primary_button.dart';
import 'package:findcaption/ui/widgets/components/textfields/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Initialize screen utils
    setupScreenUtil(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Find Caption",
          style: styleTitle.copyWith(
              fontSize: setFontSize(45), color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.language,
              color: Colors.white,
            ),
            onPressed: () {},
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
  bool onSearch = false;
  void setOnSearch(bool value) {
    setState(() {
      onSearch = value;
    });
  }

  void searchCaption(String from) {
    setOnSearch(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AnimatedCrossFade(
        firstChild: _contentEmptyWidget(), 
        secondChild: _contentFilledWidget(), 
        crossFadeState: onSearch == false
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond, 
        duration: const Duration(milliseconds: 300),
      ),
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
          _fieldSubmit("filled")
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
      color: primaryColor,
      title: "Find Now",
      fontSize: 38,
      onClick: () => searchCaption(from),
    );
  }

  Widget _fieldYoutubeUrl({Function? onEditComplete}) {
    return CustomTextField(
      hintText: "Youtube URL (ex: https://www.youtube.com/watch?)",
      action: TextInputAction.next,
      type: TextInputType.text,
      controller: youtubeUrlController,
      hintColor: blackColor.withOpacity(0.5),
      useBoldText: false,
      fontSize: 38,
      onEditComplete: onEditComplete,
    );
  }

  Widget _fieldKeyword({Function? onEditComplete}) {
    return CustomTextField(
      hintText: "Keyword",
      action: TextInputAction.done,
      type: TextInputType.text,
      controller: keywordController,
      hintColor: blackColor.withOpacity(0.5),
      useBoldText: false,
      fontSize: 38,
      onEditComplete: onEditComplete,
    );
  }
}
