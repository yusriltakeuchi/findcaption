
class CaptionModel {
  String? text;
  int? startPosition;
  double? duration;
  CaptionModel({
    this.text,
    this.startPosition,
    this.duration,
  });

  factory CaptionModel.fromJson(Map<String, dynamic> json) {
    return CaptionModel(
      text: json['text'] ?? "",
      startPosition: json['start'] != null
        ? double.parse(json['start'].toString()).toInt()
        : 0,
      duration: json['duration'] != null
        ? double.parse(json['duration'].toString())
        : 0,
    );
  }
}
