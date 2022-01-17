import 'package:findcaption/core/utils/navigation/navigation_utils.dart';
import 'package:findcaption/ui/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  final String? youtubeId;
  final int? position;
  final String? language;
  const YoutubePlayerScreen({
    Key? key,
    required this.youtubeId,
    required this.position,
    required this.language
  }) : super(key: key);
 
  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;

  void loadYoutubeController() async {
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId ?? "",
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
        captionLanguage: widget.language ?? "",
        startAt: widget.position ?? 0
      ),
    );
    _controller.toggleFullScreenMode();
  }

  @override
  void initState() {
    super.initState();
    loadYoutubeController();
  }

  @override
  void dispose() {
    _controller.toggleFullScreenMode();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.pink,
                progressColors: ProgressBarColors(
                  playedColor: primaryColor, 
                  handleColor: Colors.blueAccent
                ),
                topActions: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white), 
                    onPressed: () {
                      _controller.pause();
                      navigate.pop(data: _controller.value.position);
                    }
                  )
                ],
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                  RemainingDuration(),
                  const PlaybackSpeedButton()
                ],
              ), 
              builder: (context, player) {
                return Column(
                  children: [
                    player,
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}