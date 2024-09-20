import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/Screens/order_screen.dart';
import 'package:food_ordering_app/models/products_food.dart';

class CustomBottomSheet extends StatefulWidget {
  final String imageUrl;
  final String name;
  final double price;
  final String description;
  final Map<String, double> sizeMultipliers;
  final bool isAdmin;

  const CustomBottomSheet({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    required this.sizeMultipliers,
    required this.isAdmin,
  }) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int counter = 1;
  String selectedSize = '';
  double _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    // تعيين حجم افتراضي
    if (widget.sizeMultipliers.isNotEmpty) {
      selectedSize = widget.sizeMultipliers.keys.first;
      calculateTotalPrice(widget.price);
    }
  }

  void calculateTotalPrice(double price) {
    setState(() {
      _totalPrice =
          price * counter * (widget.sizeMultipliers[selectedSize] ?? 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: screenHeight * 0.55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: ListView(
              children: [
                Row(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: widget.imageUrl.startsWith('http')
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.imageUrl,
                                height: 120,
                                width: 120,
                                fit: BoxFit.contain,
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.image,
                                size: 120,
                                color: Colors.black,
                              ),
                            ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              widget.name,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const SizedBox(
                          width: 100,
                          child: Text(
                            '⭐⭐⭐⭐⭐',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              width: 20,
                              child: Text(
                                '\$',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Text(
                                '${_totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: widthScreen * 0.25,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: widthScreen * 0.35),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (counter > 0) {
                            counter--;
                            calculateTotalPrice(widget.price);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 50,
                        height: 30,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            '-',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$counter',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          counter++;
                          calculateTotalPrice(widget.price);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 50,
                        height: 30,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            '+',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Size',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: widthScreen * 0.2),
                    Wrap(
                      spacing: 5,
                      children: widget.sizeMultipliers.keys.map(
                        (size) {
                          return ChoiceChip(
                            label: Text(size),
                            selected: selectedSize == size,
                            onSelected: (selected) {
                              setState(() {
                                selectedSize = size;
                                calculateTotalPrice(widget.price);
                              });
                            },
                            selectedColor: Colors.orange,
                            backgroundColor: Colors.grey[200],
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'Description',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5,
                    ),
                    child: Text(
                      widget.description,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                widget.isAdmin
                    ? const Text('')
                    : ElevatedButton(
                        onPressed: () async {
                          final product = ProductFoods(
                            widget.name,
                            widget.price,
                            widget.imageUrl,
                          );

                          final cartItemId = FirebaseFirestore.instance
                              .collection('carts')
                              .doc()
                              .id;

                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            final cartRef = FirebaseFirestore.instance
                                .collection('carts')
                                .doc(user.uid);

                            final cartDoc = await cartRef.get();
                            if (cartDoc.exists) {
                              await cartRef.update({
                                'items': FieldValue.arrayUnion([
                                  {
                                    'id': cartItemId,
                                    'product': product.toMap(),
                                    'quantity': counter,
                                    'size': selectedSize,
                                    'totalPrice': _totalPrice,
                                  }
                                ])
                              });
                            } else {
                              await cartRef.set({
                                'items': [
                                  {
                                    'id': cartItemId,
                                    'product': product.toMap(),
                                    'quantity': counter,
                                    'size': selectedSize,
                                    'totalPrice': _totalPrice,
                                  }
                                ]
                              });
                            }
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.all(10),
                        ),
                      ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
