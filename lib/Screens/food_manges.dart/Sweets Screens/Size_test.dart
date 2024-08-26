import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';
import 'package:food_ordering_app/Screens/order_screen.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

// Define ProductFoods class
class ProductFoods {
  final String name;
  final double price;
  final String imageUrl;

  ProductFoods(this.name, this.price, this.imageUrl);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

class FoodList extends StatefulWidget {
  final String collectionName;
  final String searchQuery;
  final String foodName;
  final String foodDetailsRoute;

  FoodList({
    super.key,
    required this.collectionName,
    required this.searchQuery,
    required this.foodName,
    required this.foodDetailsRoute,
  });

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  int counter = 0;
  String selectedSize = 'Small'; // Default size
  final Map<String, double> sizeMultipliers = {
    'Small': 1.0,
    'Medium': 1.5,
    'Large': 2.0,
  };
  double _totalPrice = 0.0;

  final Map<ProductFoods, double> selectedProducts = {};

  void calculateTotalPrice(double basePrice) {
    double sizeMultiplier = sizeMultipliers[selectedSize] ?? 1.0;
    double totalPrice = basePrice * sizeMultiplier;
    totalPrice *= counter;
    setState(() {
      _totalPrice = totalPrice;
    });
  }

  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    checkUserRole();
  }

  Future<void> checkUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot adminDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (adminDoc.exists) {
        String role = adminDoc.get('rool');
        setState(() {
          isAdmin = role == 'admin';
        });
      } else {
        setState(() {
          isAdmin = false;
        });
      }
    } else {
      setState(() {
        isAdmin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference foodRef =
        FirebaseFirestore.instance.collection(widget.collectionName);

    final String lowercaseQuery = widget.searchQuery.toLowerCase();

    updateAllDocuments(foodRef);

    final Stream<QuerySnapshot> stream = widget.searchQuery.isNotEmpty
        ? foodRef
            .where('name_lowercase', isGreaterThanOrEqualTo: lowercaseQuery)
            .where('name_lowercase',
                isLessThanOrEqualTo: lowercaseQuery + '\uf8ff')
            .snapshots()
        : foodRef.orderBy('timestamp', descending: true).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong: ${snapshot.error}',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              widget.searchQuery.isNotEmpty
                  ? 'No results found for "${widget.searchQuery}".'
                  : 'No items available.',
              style: TextStyle(fontSize: 16, color: Colors.orange),
            ),
          );
        }

        final documents = snapshot.data!.docs;

        return ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            const Text(
              "What is your",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              'favourite ${widget.foodName}?',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final doc = documents[index];
                final data = doc.data() as Map<String, dynamic>;
                final imageUrl = data['image'] as String? ?? '';
                final name = data['name'] as String? ?? '';
                final description = data['description'] as String? ?? '';
                final priceString = data['price'] as String ?? '0.0';
                final price = double.tryParse(priceString) ?? 0.0;

                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        double widthScreen = MediaQuery.of(context).size.width;
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Container(
                            height: 600,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        child: imageUrl.startsWith('http')
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  imageUrl,
                                                  height: 120,
                                                  width: 120,
                                                  fit: BoxFit.contain,
                                                ),
                                              )
                                            : Center(
                                                child: Icon(
                                                  Icons.image,
                                                  size: 120,
                                                  color: Colors.black,
                                                ),
                                              ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: 220,
                                            ),
                                            child: Text(
                                              name,
                                              softWrap: true,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '⭐⭐⭐⭐⭐',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                '\$',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${_totalPrice.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              IconButton(
                                                onPressed: () {
                                                  if (counter > 0) {
                                                    setState(() {
                                                      counter--;
                                                      calculateTotalPrice(
                                                          price);
                                                    });
                                                  }
                                                },
                                                icon: Icon(Icons.remove),
                                              ),
                                              Text(
                                                '$counter',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    counter++;
                                                    calculateTotalPrice(price);
                                                  });
                                                },
                                                icon: Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Wrap(
                                            children: sizeMultipliers.keys.map(
                                              (size) {
                                                return ChoiceChip(
                                                  label: Text(size),
                                                  selected:
                                                      selectedSize == size,
                                                  onSelected: (selected) {
                                                    setState(() {
                                                      selectedSize = size;
                                                      calculateTotalPrice(
                                                          price);
                                                    });
                                                  },
                                                  selectedColor: Colors.orange,
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                );
                                              },
                                            ).toList(),
                                          ),
                                          SizedBox(height: 10),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (counter > 0) {
                                                Navigator.pop(context);
                                                final product = ProductFoods(
                                                    name, price, imageUrl);
                                                setState(() {
                                                  selectedProducts[product] =
                                                      _totalPrice;
                                                });
                                                // showSnackBar(
                                                //   context,
                                                //   'Added ${product.name} to cart!',
                                                // );
                                              } else {
                                                // showSnackBar(
                                                //   context,
                                                //   'Please select a quantity!',
                                                // );
                                              }
                                            },
                                            child: Text('Add to Cart'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Details',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    description,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '⭐⭐⭐⭐⭐',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\$$price',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateAllDocuments(CollectionReference collectionRef) async {
    final snapshot = await collectionRef.get();

    for (final doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final name = data['name'] as String? ?? '';
      final nameLowercase = name.toLowerCase();
      await doc.reference.update({'name_lowercase': nameLowercase});
    }
  }
}
