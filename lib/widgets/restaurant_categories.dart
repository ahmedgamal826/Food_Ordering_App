import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/category_list_view.dart';

class RestaurantCategories extends StatelessWidget {
  const RestaurantCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryListView(
          categoryName: 'Foods',
          onTap: () {
            Navigator.pushNamed(context, 'burgersScreen');
          },
        ),
        const SizedBox(height: 20),
        CategoryListView(
          categoryName: 'Drinks',
          onTap: () {
            Navigator.pushNamed(context, 'drinksScreen');
          },
        ),
        const SizedBox(height: 20),
        CategoryListView(
          categoryName: 'Sweets',
          onTap: () {
            Navigator.pushNamed(context, 'sweetsScreen');
          },
        ),
        const SizedBox(height: 20),
        CategoryListView(
          categoryName: 'Popular Meals',
          onTap: () {
            Navigator.pushNamed(context, 'offersScreen');
          },
        ),
      ],
    );
  }
}
