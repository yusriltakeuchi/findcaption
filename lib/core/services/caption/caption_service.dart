
import 'package:findcaption/core/models/caption_language_model.dart';
import 'package:findcaption/core/models/caption_model.dart';
import 'package:findcaption/core/services/base/base_services.dart';

class CaptionService extends BaseServices {

  Future<List<CaptionModel>>? getCaptions(String languageCode, String youtubeId, String keyword) async {
    var response = await request(
      api.getCaption
        .replaceAll("%language%", languageCode)
        .replaceAll("%youtube_id%", youtubeId)
        .replaceAll("%keyword%", keyword),
      RequestType.GET,
    );

    List<CaptionModel> captions = [];
    if (response != null && response.containsKey('data')) {
      captions = (response['data'] as List).map((e) => CaptionModel.fromJson(e)).toList();
    } 
    return captions;
  }

  Future<List<CaptionLanguageModel>>? getCaptionLanguages(String youtubeId) async {
    var response = await request(
      api.getCaptionLanguage
        .replaceAll("%youtube_id%", youtubeId),
      RequestType.GET,
    );

    List<CaptionLanguageModel> captionLanguages = [];
    if (response != null && response.containsKey('data')) {
      captionLanguages = (response['data'] as List).map((e) => CaptionLanguageModel.fromJson(e)).toList();
    } 
    return captionLanguages;
  }
}