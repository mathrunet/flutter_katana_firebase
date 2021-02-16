part of katana_firebase;

class FirebaseCore {
  FirebaseCore._();
  static FirebaseApp? _app;

  /// True if initialization has been completed.
  static bool get isInitialized => _app != null;
  static Future initialize() async {
    if (_app != null) {
      return;
    }
    await Localize.initialize(locale: "en_US");
    _app = await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = const Settings();
  }
}
