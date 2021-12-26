
class Api {
    
  /// Base API Endpoint
  static String? baseHost = "https://findcaption.herokuapp.com";

  /// * ------------------
  ///  * Caption Endpoint
  ///  * ------------------
  ///  * In this field will exists
  ///  * some route about caption
  /// */
  String getCaption = "$baseHost/caption/find/%language%/%youtube_id%/%keyword%";
  String getCaptionLanguage = "$baseHost/caption/supportedlanguages/%youtube_id%";
}