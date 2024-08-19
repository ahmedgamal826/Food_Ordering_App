import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/food_list.dart';
import 'package:food_ordering_app/widgets/search_textform_field.dart';

class FishAndRice extends StatefulWidget {
  const FishAndRice({super.key});

  @override
  State<FishAndRice> createState() => _FishAndRiceState();
}

class _FishAndRiceState extends State<FishAndRice> {
  String searchQuery = '';

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        title: const Text(
          'fish and rice',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FoodList(
              collectionName: 'fish and rice',
              searchQuery: searchQuery, // Pass the searchQuery here
              foodName: 'fish and rice',
              foodDetailsRoute: 'sushiScreen',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: const Icon(
            Icons.add,
            size: 33,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddFoodPage(
                  collectionName: 'fish and rice',
                  categoryName: 'Foods',
                ),
              ),
            );
          }),
    );
  }
}
