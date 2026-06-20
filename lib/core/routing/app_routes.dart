class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String scan = '/scan';
  static const String verify = '/verify';
  static const String riskMap = '/risk-map';
  static const String history = '/history';
  static const String offline = '/offline';
  static const String aiAnalysis = '/ai-analysis';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String scannerCamera = '/scan/camera';
}

class VerifyRouteArgs {
  const VerifyRouteArgs({this.batchCode});

  final String? batchCode;
}
