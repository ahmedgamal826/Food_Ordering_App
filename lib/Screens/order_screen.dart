import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/special_food_model.dart';
import 'package:food_ordering_app/models/special_offers_model.dart';
import 'package:food_ordering_app/widgets/orders_list.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class MyOrderScreen extends StatefulWidget {
  MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  Map<SpecialFood, int> foodCounters = {};
  Map<SpecialOffers, int> foodOffersCounters = {};
  List<dynamic> combinedOrderList = [];
  double deliveryFee = 0.0;
  int selectedPaymentMethod = 1; // 1 for Credit card, 2 for Debit card

  @override
  void initState() {
    super.initState();

    // Initialize the food counters from orderList
    for (var food in orderList) {
      foodCounters[food] = (foodCounters[food] ?? 0) + 1;
    }

    // Initialize the food counters from specialOrderList
    for (var foodOffers in specialOrderList) {
      foodOffersCounters[foodOffers] =
          (foodOffersCounters[foodOffers] ?? 0) + 1;
    }

    // Combine orderList and specialOrderList into a single list
    combinedOrderList = [...orderList, ...specialOrderList];
  }

  double calculateTotalPrice() {
    double total = 0.0;
    foodCounters.forEach((food, count) {
      total += food.price * count;
    });
    foodOffersCounters.forEach((offer, count) {
      total += offer.price * count;
    });
    return total;
  }

  void showOrderConfirmation(BuildContext context, double totalPrice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.65,
              maxChildSize: 0.7,
              minChildSize: 0.5,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 5,
                              width: 50,
                              color: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Order Confirmation',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            color: Colors.white,
                            child: ListTile(
                              leading:
                                  Image.asset('assets/images/master_card.png'),
                              title: const Text('Credit card'),
                              subtitle: const Text('2451 **** **** 2548'),
                              trailing: Radio(
                                value: 1,
                                groupValue: selectedPaymentMethod,
                                onChanged: (value) {
                                  setModalState(() {
                                    selectedPaymentMethod = value as int;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            child: ListTile(
                              leading:
                                  Image.asset('assets/images/visa_image.png'),
                              title: const Text('Debit card'),
                              subtitle: const Text('1326 **** **** 6214'),
                              trailing: Radio(
                                value: 2,
                                groupValue: selectedPaymentMethod,
                                onChanged: (value) {
                                  setModalState(() {
                                    selectedPaymentMethod = value as int;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Delivery Address',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text('Gosala 1road, Sirajganj...'),
                            trailing: Icon(Icons.edit),
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery time:',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '15-20 Min',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Delivery services:',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '\$${deliveryFee.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${(totalPrice + deliveryFee).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Handle payment logic
                              setState(() {
                                print('Payment Completed');
                                Navigator.pop(context);
                                handlePayment(totalPrice + deliveryFee);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Make a payment',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void handlePayment(double totalAmount) {
    // Add your payment handling logic here

    // Show Snackbar after payment handling
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Payment of \$${totalAmount.toStringAsFixed(2)} completed!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Order',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: combinedOrderList.length,
                itemBuilder: (context, index) {
                  var item = combinedOrderList[index];
                  if (item is SpecialFood) {
                    SpecialFood food = item;
                    int counter = foodCounters[food] ?? 1;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            orderList.remove(food);
                            foodCounters.remove(food);
                            combinedOrderList.remove(food);

                            customShowSnackBar(
                                context: context,
                                content: '${food.title} is removed from cart');
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                food.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              food.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '\$${food.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (counter > 1) {
                                        foodCounters[food] = counter - 1;
                                      }
                                    });
                                  },
                                  child: Container(
                                    color: Colors.orange,
                                    width: 30,
                                    height: 30,
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  counter.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      foodCounters[food] = counter + 1;
                                    });
                                  },
                                  child: Container(
                                    color: Colors.orange,
                                    width: 30,
                                    height: 30,
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (item is SpecialOffers) {
                    SpecialOffers foodOffer = item;
                    int offerCounter = foodOffersCounters[foodOffer] ?? 1;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            specialOrderList.remove(foodOffer);
                            foodOffersCounters.remove(foodOffer);
                            combinedOrderList.remove(foodOffer);

                            customShowSnackBar(
                                context: context,
                                content:
                                    '${foodOffer.title} is removed from cart');
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                foodOffer.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              foodOffer.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '\$${foodOffer.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (offerCounter > 1) {
                                        foodOffersCounters[foodOffer] =
                                            offerCounter - 1;
                                      }
                                    });
                                  },
                                  child: Container(
                                    color: Colors.orange,
                                    width: 30,
                                    height: 30,
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  offerCounter.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      foodOffersCounters[foodOffer] =
                                          offerCounter + 1;
                                    });
                                  },
                                  child: Container(
                                    color: Colors.orange,
                                    width: 30,
                                    height: 30,
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox
                        .shrink(); // Empty widget if item is neither
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showOrderConfirmation(context, totalPrice);
                // handlePayment(totalPrice);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Center(
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
