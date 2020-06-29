import 'package:carbon_counter/api/calculations/calculations.dart';
import 'package:http/http.dart' as http;

/// Responsible for fetching and parsing web objects.
/// API is initialized when the app starts.
/// Once the class is initialized, it's provides single instance.
class API {
  // Stores the instance of API class
  static API _singleton;

  // Each resource has it own class
  // The requests should be implemented in those classes
  final CalculationsApi calculate;

  // Private constructor. Used only first time when class is constructed
  API._internal(this.calculate);

  /// Factory constructor. Initiates and Returns singleton.
  factory API() {
    http.Client client = http.Client();
    // Check if instance exists
    if (_singleton == null) {
      _singleton = API._internal(
        CalculationsApi(client: client),
      );
    }

    // Return the instance
    return _singleton;
  }
}
