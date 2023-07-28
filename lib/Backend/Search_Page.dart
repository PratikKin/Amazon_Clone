import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchItems {
  Future<dynamic> getSearchResults(String searchData) async {
    final apiUrl =
        'https://dev2be.oruphones.com/api/v1/global/assignment/searchModel';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"searchModel": searchData});

    try {
      final response = await HttpHelper.post(apiUrl, headers, body);

      if (response != null) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      print('Error during API call: $e');
      return null;
    }
  }
}

class HttpHelper {
  static Future<Map<String, dynamic>> post(
      String url, Map<String, String> headers, dynamic body) async {
    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error during API call: $e');
      return {};
    }
  }
}
