import 'dart:convert';

import 'package:http/http.dart' as http;

int limit = 10;

class Customer_Sales {
  Future<dynamic> getSalesmanDetails() async {
    var url = Uri.https(
        'dev2be.oruphones.com',
        '/api/v1/global/assignment/getListings',
        {'page': '2', 'limit': '$limit'});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
