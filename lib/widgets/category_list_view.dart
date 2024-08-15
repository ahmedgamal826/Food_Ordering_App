// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/widgets/custom_category.dart';

// class CategoryListView extends StatelessWidget {
//   const CategoryListView({super.key, required this.categoryName});

//   final String categoryName;

//   @override
//   Widget build(BuildContext context) {
//     ScrollController _scrollController = ScrollController();
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 20, bottom: 10),
//           child: Row(
//             children: [
//               Text(
//                 '$categoryName',
//                 style: const TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Spacer(),
//               TextButton(
//                 onPressed: () {
//                   _scrollController.animateTo(
//                       _scrollController.position.maxScrollExtent,
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeIn);
//                 },
//                 child: const Text(
//                   'View all >',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Color(0xffF97316),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 100,
//           child: ListView(
//             controller: _scrollController,
//             scrollDirection: Axis.horizontal,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.pushNamed(context, 'burgerScreen');
//                 },
//                 child: CustomCategory(
//                   categoryName: 'Burger',
//                   image: 'assets/images/burger.png',
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.pushNamed(context, 'pizzaScreen');
//                 },
//                 child: CustomCategory(
//                   categoryName: 'Pizza',
//                   image: 'assets/images/pizza.png',
//                 ),
//               ),
//               CustomCategory(
//                 categoryName: 'Chicken',
//                 image: 'assets/images/chicken.png',
//               ),
//               CustomCategory(
//                 categoryName: 'Pasta',
//                 image: 'assets/images/pasta.png',
//               ),
//               CustomCategory(
//                 categoryName: 'Sushi',
//                 image: 'assets/images/sushi.png',
//               ),
//               CustomCategory(
//                 image: 'assets/images/drink.png',
//                 categoryName: 'Drinks',
//               ),
//               CustomCategory(
//                 image: 'assets/images/desserts.png',
//                 categoryName: 'Desserts',
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/custom_category.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    List<CustomCategory> categories = [];
    if (categoryName == 'Drinks') {
      categories = [
        CustomCategory(
          image: 'assets/images/coffee.png',
          categoryName: 'Coffee',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/tea.png',
          categoryName: 'Tea',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/soda.png',
          categoryName: 'Pepsi',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/water-bottle.png',
          categoryName: 'Water',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/lemonade.png',
          categoryName: 'Lemonade Juice',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/strawberry-juice.png',
          categoryName: 'Strawberry Juice',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/orange-juice.png',
          categoryName: 'Orange Juice',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
      ];
    } else if (categoryName == 'Foods') {
      categories = [
        CustomCategory(
          categoryName: 'Burger',
          image: 'assets/images/burger.png',
          onTap: () {
            Navigator.pushNamed(context, 'burgerScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Pizza',
          image: 'assets/images/pizza.png',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Chicken',
          image: 'assets/images/chicken.png',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Fish',
          image: 'assets/images/fish.png',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Meat',
          image: 'assets/images/meat.png',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Pasta',
          image: 'assets/images/pasta.png',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Sushi',
          image: 'assets/images/sushi.png',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
      ];
    } else if (categoryName == 'Sweets') {
      categories = [
        CustomCategory(
          categoryName: 'Chocolate Cake',
          image: 'assets/images/chocolate-cake.png',
          onTap: () {
            Navigator.pushNamed(context, 'burgerScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Donut',
          image: 'assets/images/donut.png',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Ice Cream',
          image: 'assets/images/ice-cream.png',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Waffle',
          image: 'assets/images/waffle.png',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/desserts.png',
          categoryName: 'Cupcake',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        )
      ];
    } else if (categoryName == 'Popular Offers') {
      categories = [
        CustomCategory(
          image: 'assets/images/burger and drink.png',
          categoryName: 'Burger + Pepsi',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/fish and rice.png',
          categoryName: 'Fish + Rice',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/meat and drink.png',
          categoryName: 'Meat + Juice',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/fast-food (2).png',
          categoryName: 'Burger + Fries',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/fast-food (3).png',
          categoryName: 'Donuts + Fries',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/bakery.png',
          categoryName: 'Cake + Donuts',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          image: 'assets/images/fastfood.png',
          categoryName: 'Burger + Fries',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
      ];
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Row(
            children: [
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
                child: const Text(
                  'View all >',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffF97316),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: categories,
          ),
        ),
      ],
    );
  }
}
