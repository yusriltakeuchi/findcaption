
class CaptionLanguageModel {
  String? code;
  String? name;
  CaptionLanguageModel({
    this.code,
    this.name,
  });

  factory CaptionLanguageModel.fromJson(Map<String, dynamic> json) {
    return CaptionLanguageModel(
      code: json['code'] ?? "",
      name: json['name'] ?? "",
    );
  }
}
