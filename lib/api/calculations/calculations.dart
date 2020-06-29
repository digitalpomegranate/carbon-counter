import 'dart:convert';

import 'package:carbon_counter/api/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Initialized and used inside SubjectiveGuideAPI class.
/// Does the API requests for User related endpoints.
class CalculationsApi {
  final http.Client client;

  /// Users API default constructor.
  CalculationsApi({this.client});

  Future<Map> calculate({
    @required String category,
    @required String formulaName,
    String distance,
    String kw,
  }) async {
    // Encode json.
    String encodedJson = json.encode({
      "distance": distance,
      "human_count": 1,
      "category": category,
      "formula_name": formulaName,
      "spent_kw": kw,
    });

    // POST request
    http.Response response = await client.post(
      Urls.calculationUrl,
      body: encodedJson,
      headers: {'Content-type': 'application/json'},
    );

    // Decode derived data.
    Map decodedJson = json.decode(response.body);

    return decodedJson;
  }
}
