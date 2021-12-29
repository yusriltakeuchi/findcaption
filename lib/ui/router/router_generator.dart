
import 'package:findcaption/core/models/caption_language_model.dart';
import 'package:findcaption/ui/router/route_list.dart';
import 'package:findcaption/ui/screens/home/home_pick_language_screen.dart';
import 'package:findcaption/ui/screens/home/home_screen.dart';
import 'package:findcaption/ui/screens/player/youtube_player_screen.dart';
import 'package:flutter/material.dart';

class RouterGenerator {

  /// Initializing route
  static Route<dynamic>? generate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      /// Home group
      case routeHome:
        return MaterialPageRoute(builder: (_) => const HomeScreen(), settings: const RouteSettings(name: routeHome));
      case routeHomePickLanguage:
        if (args is List<CaptionLanguageModel>?) {
          return MaterialPageRoute(builder: (_) => HomePickLanguageScreen(
            languages: args,
          ), settings: const RouteSettings(name: routeHomePickLanguage));
        }
        break;
    
      /// Video player group
      case routeVideoPlayer:
        if (args is List) {
          return MaterialPageRoute(builder: (_) => YoutubePlayerScreen(
            youtubeId: args[0],
            position: args[1],
          ), settings: const RouteSettings(name: routeVideoPlayer));
        }
    }
  }
}