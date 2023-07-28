import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Backend/Search_Page.dart';
import '../Frontend//HomePage.dart';

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchControl = TextEditingController();

  List<String> AvailableSearchedList = [];

  List<String> filteredItems = [];

  Timer? _debounceTimer;
  void filterItems(String query) {
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 50), () {
      setState(() {
        filteredItems = AvailableSearchedList.where(
                (item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void getProduct(BuildContext context, {required String searchData}) async {
    var dataDecoded = await SearchItems().getSearchResults(searchData);
    CreateCard(dataDecoded);
  }

  void CreateCard(dynamic searchListData) {
    if (searchListData != null) {
      List<String> productList = [];
      for (String data in searchListData['models']) {
        productList.add(data);
        print(data);
      }
      setState(() {
        AvailableSearchedList = productList;
        filterItems(searchControl.text);
      });
    } else {
      print('data is empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.blueGrey.shade700,
        elevation: 0.0,
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20.0,
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
                controller: searchControl,
                onTap: () {},
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefix: SizedBox(
                    width: 10.0,
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      getProduct(context, searchData: searchControl.text);
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredItems[index]),
                    onTap: () {
                      // Do something when an item is tapped
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
