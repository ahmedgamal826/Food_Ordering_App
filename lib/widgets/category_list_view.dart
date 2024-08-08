import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/custom_category.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Row(
            children: [
              const Text(
                'Category',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
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
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'burgerScreen');
                },
                child: CustomCategory(
                  categoryName: 'Burger',
                  image: 'assets/images/burger.png',
                ),
              ),
              CustomCategory(
                categoryName: 'Pizza',
                image: 'assets/images/pizza.png',
              ),
              CustomCategory(
                categoryName: 'Pasta',
                image: 'assets/images/pasta.png',
              ),
              CustomCategory(
                categoryName: 'Sushi',
                image: 'assets/images/sushi.png',
              ),
              CustomCategory(
                image: 'assets/images/drink.png',
                categoryName: 'Drinks',
              ),
              CustomCategory(
                image: 'assets/images/desserts.png',
                categoryName: 'Desserts',
              )
            ],
          ),
        ),
      ],
    );
  }
}
