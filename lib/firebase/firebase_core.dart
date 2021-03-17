part of katana_firebase;

/// Class that prepares to handle Firebase.
///
/// Please be sure to initialize by executing [initialize].
///
/// ```
/// await FirebaseCore.initialize();
/// ```
class FirebaseCore {
  FirebaseCore._();
  static FirebaseApp? _app;

  /// True if initialization has been completed.
  static bool get isInitialized => _app != null;

  static late String region;

  /// Initialize Firebase.
  static Future<void> initialize({String region = "asia-northeast1"}) async {
    if (_app != null) {
      return;
    }
    FirebaseCore.region = region;
    await Localize.initialize(locale: "en_US");
    _app = await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = const Settings();
  }
}
