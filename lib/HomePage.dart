import 'package:amazon/Backend/Customers_Sales.dart';
import 'package:amazon/Filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProductInfo.dart';
import 'SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Widget> AvailableProductList = [];

class _HomePageState extends State<HomePage> {
  void getProduct(BuildContext context) async {
    var dataDecoded = await Customer_Sales().getSalesmanDetails();
    CreateCard(dataDecoded);
  }

  @override
  void initState() {
    super.initState();
    getProduct(context);
  }

  void CreateCard(dynamic customerSales) {
    if (customerSales != null) {
      List<Widget> productList = [];
      for (var listing in customerSales['listings']) {
        var picUrl = listing['images'][0]['fullImage'];
        var deviceCondn = listing['deviceCondition'];
        var date = listing['listingDate'].toString();
        var price = listing['listingNumPrice'].toInt();
        var modelName = listing['model'];
        var storage = listing['deviceStorage'];
        var City = listing['listingLocation'];

        productList.add(
          Product(
            picUrl: picUrl,
            deviceCondn: deviceCondn,
            date: date,
            price: price,
            modelName: modelName,
            storage: storage,
            City: City,
          ),
        );
      }
      setState(() {
        AvailableProductList = productList;
      });
    } else {
      print('data is empty');
    }
  }

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.blueGrey.shade700,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.white,
            size: 35.0,
          ),
        ),
        title: Image.asset(
          "assets/main_logo.png",
          height: 45.0,
          width: 80.0,
        ),
        actions: [
          Row(
            children: [
              Text(
                "India",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Icon(
                Icons.location_on_sharp,
                size: 30.0,
              ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Icon(
            CupertinoIcons.bell,
            size: 35.0,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.square(5.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Container(
              height: 40.0,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
                color: Colors.white30,
              ),
              child: TextFormField(
                controller: search,
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SearchApp()));
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefix: SizedBox(
                    width: 10.0,
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        // Changed SingleChildScrollView to Column
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18.0, top: 15.0),
            child: Text(
              "Buy Top Brands",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          SingleChildScrollView(
            child: Row(
              children: [
                Logo(
                  image: "assets/apple.png",
                ),
                Logo(
                  image: "assets/samsung.png",
                ),
                Logo(
                  image: "assets/mi.png",
                ),
                Logo(
                  image: "assets/vivo.png",
                ),
                Logo(
                  image: "assets/realme.png",
                ),
              ],
            ),
            scrollDirection: Axis.horizontal,
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Best deals near you"),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FiltersScreen(),
                          ),
                        );
                      },
                      child: Text("Filters"),
                    ),
                    Icon(
                      CupertinoIcons.arrow_up_arrow_down,
                      size: 15.0,
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: AvailableProductList,
            ),
          ),
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  Logo({required this.image});
  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          height: 80.0,
          width: 100.0,
          child: Image.asset(image),
        ),
      ),
    );
  }
}
