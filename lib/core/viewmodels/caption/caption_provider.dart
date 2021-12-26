import 'package:findcaption/core/models/caption_language_model.dart';
import 'package:findcaption/core/models/caption_model.dart';
import 'package:findcaption/core/services/caption/caption_service.dart';
import 'package:findcaption/injector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaptionProvider extends ChangeNotifier {
  ///=========================
  /// This is property field 
  ///=========================
 
  /// List of captions
  List<CaptionModel>? _captions;
  List<CaptionModel>? get captions => _captions;

  /// List of caption languages
  List<CaptionLanguageModel>? _captionLanguages;
  List<CaptionLanguageModel>? get captionLanguages => _captionLanguages;
  CaptionLanguageModel? _selectedCaptionLanguage;
  CaptionLanguageModel? get selectedCaptionLanguage => _selectedCaptionLanguage;

  String? _currentYoutubeId;
  String? get currentYoutubeId => _currentYoutubeId;
  String? _currentKeyword;
  String? get currentKeyword => _currentKeyword;

  bool? _searchCaptionMode = false;
  bool? get searchCaptionMode => _searchCaptionMode;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Dependency injection
  final captionService = locator<CaptionService>();

  ///=========================
  /// This is function logic 
  ///=========================

  /// Instance provider
  static CaptionProvider instance(BuildContext context)
  => Provider.of(context, listen: false);
  
  /// Write your function in here
  void getCaptions(String languageCode, String youtubeId, String keyword) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    _currentYoutubeId = youtubeId;
    _currentKeyword = keyword;

    var result = await captionService.getCaptions(languageCode, youtubeId, keyword);
    _captions = [];
    _captions = result;

    setOnSearch(false);
  }

  Future getCaptionLanguages(String youtubeId) async {
    var result = await captionService.getCaptionLanguages(youtubeId);
    _captionLanguages = [];
    _captionLanguages = result;
    notifyListeners();
  }

  void setSelectedCaptionLanguage(CaptionLanguageModel value) {
    _selectedCaptionLanguage = value;
    notifyListeners();
  }

  void setSearchMode(bool? value) {
    _searchCaptionMode = value;
    notifyListeners();
  }

  /// Set event search
  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  void clearCaptions() {
    _captions = null;
    notifyListeners();
  }
}