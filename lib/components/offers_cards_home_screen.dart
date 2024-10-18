import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/constants_variables.dart';

class OffersCards extends StatelessWidget {
  const OffersCards({
    super.key,
    required this.pageController,
    required this.offers,
  });

  final PageController pageController;
  final List<Map<String, dynamic>> offers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.2,
      child: PageView.builder(
        controller: pageController,
        itemCount: offers.length,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: const Duration(
              seconds: 1,
            ),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.orange.shade600,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // shadow position
                ),
              ],
            ),
            width: width(context) * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${offers[index]['offerDiscount']}% OFF',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${offers[index]['name']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      offers[index]['image'],
                      height: height(context) * 0.6,
                      width: width(context) * 0.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
