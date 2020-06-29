class Urls {
  static final String _baseUrl =
      'https://us-central1-carbon-counter-1a8c1.cloudfunctions.net';
  static final String _calculation = '/co2_counter';

  static String get baseUrl {
    return _baseUrl;
  }

  static String get calculationUrl {
    return '$_baseUrl$_calculation';
  }
}
