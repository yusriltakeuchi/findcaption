
class Api {
    
  /// Base API Endpoint
  static String? baseHost = "https://127.0.0.1:5000";

  /// * ------------------
  ///  * Caption Endpoint
  ///  * ------------------
  ///  * In this field will exists
  ///  * some route about caption
  /// */
  String getCaption = "$baseHost/caption/find/%language%/%youtube_id%/%keyword%";
}