import 'package:flutter/material.dart';

import '../Backend/Filter_Sales.dart';
import '../Frontend//HomePage.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

List<String> makeFilters = [];
List<String> conditionFilters = [];
List<String> storageFilters = [];
List<String> ramFilters = [];

class _FiltersScreenState extends State<FiltersScreen> {
  List<String> filters = [];
  String? selectedFilter; // Declare selectedFilter as nullable
  late Map<String, dynamic> allFilters;
  Map<String, Set<String>> selectedSpecifications =
      {}; // Store selected specifications for each filter

  @override
  void initState() {
    super.initState();
    fetchFilters();
  }

  void fetchFilters() async {
    try {
      var response = await Filter_Sales().getFiltersDetails();
      if (response != null) {
        setState(() {
          allFilters = response['filters'];
          filters = allFilters.keys.toList();

          // Initialize selectedSpecifications with an empty set for each filter
          for (String filter in filters) {
            selectedSpecifications[filter] = {};
          }
        });
      } else {
        print("The response is empty");
      }
    } catch (e) {
      print('Error fetching filters: $e');
    }
  }

  void _toggleSpecification(String filter, String specification) {
    setState(() {
      if (selectedSpecifications[filter]!.contains(specification)) {
        // If specification is already selected, remove it
        selectedSpecifications[filter]!.remove(specification);
      } else {
        // If specification is not selected, add it
        selectedSpecifications[filter]!.add(specification);
      }
    });
  }

  void _applyFilters() {
    // Create separate variables to hold selected specifications for each filter

    // Extract selected specifications from the selectedSpecifications map
    selectedSpecifications.forEach((filter, specifications) {
      switch (filter) {
        case 'make':
          makeFilters.addAll(specifications);
          break;
        case 'condition':
          conditionFilters.addAll(specifications);
          break;
        case 'storage':
          storageFilters.addAll(specifications);
          break;
        case 'ram':
          ramFilters.addAll(specifications);
          break;
        // Add cases for other filter categories if needed
        default:
          break;
      }
    });

    // Now, the selected filters are stored in separate variables:
    print('Selected Make Filters: $makeFilters');
    print('Selected Condition Filters: $conditionFilters');
    print('Selected Storage Filters: $storageFilters');
    print('Selected RAM Filters: $ramFilters');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text('Filters'),
        actions: [
          TextButton(
            onPressed: _applyFilters,
            child: Text(
              'Apply filters',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[200], // Replace with your desired side menu color
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Your side menu content here
              for (String filter in filters)
                Column(
                  children: [
                    ListTile(
                      title: Text(
                        filter,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    for (String specification in allFilters[filter])
                      ListTile(
                        title: TextButton(
                          onPressed: () {
                            _toggleSpecification(filter, specification);
                          },
                          child: Text(specification),
                          style: TextButton.styleFrom(
                            primary: selectedSpecifications[filter]!
                                    .contains(specification)
                                ? Colors
                                    .blue // Highlight selected specifications
                                : Colors.black,
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
