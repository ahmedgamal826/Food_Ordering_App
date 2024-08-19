import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/food_list.dart';
import 'package:food_ordering_app/widgets/search_textform_field.dart';

class BurgerFriesLast extends StatefulWidget {
  const BurgerFriesLast({super.key});

  @override
  State<BurgerFriesLast> createState() => _BurgerFriesLastState();
}

class _BurgerFriesLastState extends State<BurgerFriesLast> {
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
          'burger and fries1',
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
              collectionName: 'burger and fries1',
              searchQuery: searchQuery, // Pass the searchQuery here
              foodName: 'burger and fries1',
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
                  collectionName: 'burger and fries1',
                  categoryName: 'Foods',
                ),
              ),
            );
          }),
    );
  }
}
