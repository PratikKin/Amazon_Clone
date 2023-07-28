import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String picUrl;
  final String deviceCondn;
  final String? date;
  final int price;
  final String modelName;
  final String storage;
  final String City;

  Product({
    required this.picUrl,
    required this.deviceCondn,
    required this.date,
    required this.price,
    required this.modelName,
    required this.storage,
    required this.City,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                picUrl,
                height: 80.0,
                width: 100.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹$price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(modelName),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    storage,
                    style: TextStyle(fontSize: 10.0),
                  ),
                  Text(
                    "Condition: " + deviceCondn,
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    City,
                    style: TextStyle(fontSize: 10.0),
                  ),
                  Text(
                    "$date",
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
