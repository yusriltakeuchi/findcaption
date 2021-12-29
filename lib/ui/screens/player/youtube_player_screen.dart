import 'package:findcaption/core/utils/navigation/navigation_utils.dart';
import 'package:findcaption/ui/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  final String? youtubeId;
  final int? position;
  const YoutubePlayerScreen({
    Key? key,
    this.youtubeId,
    this.position,
  }) : super(key: key);
 
  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;

  void loadYoutubeController() async {
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
        useHybridComposition: false,
        startAt: widget.position!
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
    );
  }
}