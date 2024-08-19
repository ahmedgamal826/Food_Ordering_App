import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/food_list.dart';
import 'package:food_ordering_app/widgets/search_textform_field.dart';

class MeatAndJuice extends StatefulWidget {
  const MeatAndJuice({super.key});

  @override
  State<MeatAndJuice> createState() => _MeatAndJuiceState();
}

class _MeatAndJuiceState extends State<MeatAndJuice> {
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
          'meat and juice',
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
              collectionName: 'meat and juice',
              searchQuery: searchQuery, // Pass the searchQuery here
              foodName: 'meat and juice',
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
                  collectionName: 'meat and juice',
                  categoryName: 'Foods',
                ),
              ),
            );
          }),
    );
  }
}
