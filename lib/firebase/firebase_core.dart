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
  // ignore: prefer_final_fields
  static List<VoidCallback> _transactionQueue = [];

  /// Enqueue a new [transaction].
  static void enqueueTransaction(VoidCallback transaction) {
    _transactionQueue.insertFirst(transaction);
  }

  /// True if initialization has been completed.
  static bool get isInitialized => _app != null;

  /// Firebase Regions.
  static late String region;

  /// Initialize Firebase.
  static Future<void> initialize({
    String region = "asia-northeast1",
    int transactionDurationMilliSeconds = 100,
  }) async {
    if (_app != null) {
      return;
    }
    FirebaseCore.region = region;
    await Localize.initialize(locale: "en_US");
    _app = await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = const Settings();
    Timer.periodic(
      Duration(milliseconds: transactionDurationMilliSeconds),
      _handledTransaction,
    );
  }

  static void _handledTransaction(Timer timer) {
    if (_transactionQueue.isEmpty) {
      return;
    }
    final transaction = _transactionQueue.last;
    _transactionQueue.removeLast();
    transaction.call();
  }
}
