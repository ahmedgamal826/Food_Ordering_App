import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/special_food_model.dart';
import 'package:food_ordering_app/models/special_offers_model.dart';
import 'package:food_ordering_app/widgets/orders_list.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:food_ordering_app/widgets/special_food_list.dart';
import 'package:food_ordering_app/widgets/special_offers_list.dart';

class SpecialOffersListView extends StatelessWidget {
  const SpecialOffersListView({super.key});

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
                'Special Offers',
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
          height: 270,
          child: ListView.builder(
            itemCount: specialFoods.length,
            itemBuilder: (context, index) {
              SpecialOffers specialOffer = specialOffers[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: [
                          Image.network(
                            specialOffer.imageUrl,
                            width: 200,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 10,
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  specialOffer.offer,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      specialOffer.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          '\$${specialOffer.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          onPressed: () {
                            specialOrderList.add(specialOffer);
                            customShowSnackBar(
                                context: context,
                                content:
                                    '${specialOffer.title} is added to cart');
                          },
                          child: Text(
                            'Add to cart',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
