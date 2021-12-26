
import 'package:findcaption/core/viewmodels/caption/caption_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderStarter {

  /// Register your provider here
  static Future<List<SingleChildWidget>> register() async => [
    ChangeNotifierProvider(create: (context) => CaptionProvider()),
  ];
 
}