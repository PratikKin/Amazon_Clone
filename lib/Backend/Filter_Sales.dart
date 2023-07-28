import 'dart:convert';

import 'package:http/http.dart' as http;

class Filter_Sales {
  final String apiUrl;

  Filter_Sales(
      {this.apiUrl =
          'https://dev2be.oruphones.com/api/v1/global/assignment/getFilters?isLimited=true'});

  Future<Map<String, dynamic>> getFiltersDetails() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch filters');
      }
    } catch (e) {
      throw Exception('Error fetching filters: $e');
    }
  }
}
