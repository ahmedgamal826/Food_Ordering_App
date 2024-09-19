import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/user_home_page.dart';
import 'package:food_ordering_app/widgets/map_screen.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class CheckoutButton extends StatefulWidget {
  CheckoutButton({
    super.key,
    required this.deliveryPrice,
    required this.total,
    required this.customerName,
    required this.items,
  });

  double deliveryPrice;
  double total;
  String customerName;
  final List<dynamic> items;

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int selectedCard = 0;
  String selectedCardName = 'Credit card';

  String deliveryAddress = "";

  bool isLoading = false;

  // Method to update the address
  void _updateAddress(String newAddress) {
    setState(() {
      deliveryAddress = newAddress;
    });
  }

  Future<void> addToCart({
    required String customerName,
    required String deliveryAddress,
    required double total,
    required double deliveryPrice,
    required List<dynamic> itemsCarts,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception("User is not logged in.");
    }

    await FirebaseFirestore.instance.collection('cartsUser').add({
      'userId': userId, // Store the user ID
      'customerName': customerName,
      'deliveryAddress': deliveryAddress,
      'total': total,
      'deliveryPrice': deliveryPrice,
      'items': itemsCarts,
      'timestamp': FieldValue.serverTimestamp(), // Store order time
    });
  }

  // Method to get the current location
  Future<loc.LocationData?> _getCurrentLocation() async {
    loc.Location location = loc.Location();
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    // Check if location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check for location permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return null;
      }
    }

    // Return current location
    return await location.getLocation();
  }

  // Method to get the address and show it in a dialog
  Future<void> getLocation(BuildContext context, StateSetter setState) async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    loc.LocationData? _currentLocation = await _getCurrentLocation();

    if (_currentLocation == null) {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
      // Handle the error if location is not available
      return;
    }

    // Convert coordinates to address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _currentLocation.latitude!,
      _currentLocation.longitude!,
    );

    String _address;

    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      _address = '${placemark.street}';
    } else {
      _address = 'Address not found';
    }

    // Update the address and hide loading indicator
    setState(() {
      deliveryAddress = _address;
      isLoading = false;
    });

    // Show the address in a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Current Address",
          style: TextStyle(
            color: Colors.orange,
          ),
        ),
        content: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
            : Text(
                _address,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  Navigator.of(context).pop();
                  _navigateToMap(context, _currentLocation);
                },
                child: const Text(
                  "View on Map",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToMap(
      BuildContext context, loc.LocationData? locationData) async {
    if (locationData == null) {
      locationData = await _getCurrentLocation();
    }

    if (locationData == null) {
      // Handle the error if location is not available
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapScreen(
          locationData: locationData!,
        ),
      ),
    );
  }

  void _selectCard(int cardValue, String cardName, StateSetter setState) {
    if (mounted) {
      setState(() {
        selectedCard = cardValue;
        selectedCardName = cardName; // Update the selected card name
      });
    }
  }

  void showInvoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Invoice',
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: [
                    const Text(
                      'Customer Name: ',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        widget.customerName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Card Type: ',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        selectedCardName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Delivery Address: ',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        '$deliveryAddress',
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Delivery Price: ',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      '\$${widget.deliveryPrice.toStringAsFixed(2)}',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Products:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                ...widget.items.map((item) {
                  final product =
                      item['product'] as Map<String, dynamic>? ?? {};
                  final productName = product['name'] as String? ?? '';
                  final quantity = item['quantity'] as int? ?? 0;
                  final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

                  return ListTile(
                    leading: Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    title: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      '$productName',
                    ),
                    trailing: Text(
                      '\$${itemTotalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                const Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Colors.orange,
                  thickness: 3,
                ),
                ListTile(
                  leading: const Text(
                    'Total: ',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '\$${widget.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () async {
                final userId = FirebaseAuth.instance.currentUser?.uid;

                if (userId == null) {
                  // Handle the case when userId is null
                  customShowSnackBar(
                    context: context,
                    content: "User is not logged in.",
                  );
                  return;
                }

                // Pass the data to the function
                await addToCart(
                  customerName: widget.customerName,
                  deliveryAddress: deliveryAddress,
                  total: widget.total,
                  deliveryPrice: widget.deliveryPrice,
                  itemsCarts: widget.items,
                );

                final cartRef =
                    FirebaseFirestore.instance.collection('carts').doc(userId);
                final cartSnapshot = await cartRef.get();
                final cartData = cartSnapshot.data() as Map<String, dynamic>?;

                if (cartData != null) {
                  // If you want to remove all items, simply set 'items' to an empty list
                  await cartRef.update({'items': []});
                } else {
                  customShowSnackBar(
                    context: context,
                    content: "Cart not found.",
                  );
                }

                // Navigate to UserHomePage and remove all
                //previous pages from the navigation stack
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserHomePage(),
                  ),
                  (route) => false, // Remove all previous routes
                );

                customShowSnackBar(
                    context: context,
                    content: 'The Purchase Completed Successfully.');
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatCardNumber(String cardNumber) {
    final buffer = StringBuffer();
    for (int i = 0; i < cardNumber.length; i++) {
      buffer.write(cardNumber[i]);
      if ((i + 1) % 4 == 0 && i != cardNumber.length - 1) {
        buffer.write(' '); // Add space every 4 digits
      }
    }
    return buffer.toString();
  }

  void _showCheckoutBottomSheet(BuildContext context, String? userId) {
    List<DocumentSnapshot>? cardList;
    bool isLoadingCards = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            if (isLoadingCards && cardList == null) {
              _firestore
                  .collection('myCards')
                  .where('userId', isEqualTo: userId)
                  .get()
                  .then((snapshot) {
                setState(() {
                  cardList = snapshot.docs;
                  isLoadingCards = false;
                });
              }).catchError((error) {
                setState(() {
                  isLoadingCards = false;
                });
              });
            }

            // Determine the height of the SizedBox
            double bottomSheetHeight = cardList == null || cardList!.isEmpty
                ? MediaQuery.of(context).size.height * 0.55
                : MediaQuery.of(context).size.height * 0.82;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffF4F4F4),
              ),
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: bottomSheetHeight,
                child: ListView(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Order Confirmation',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (isLoadingCards)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      )
                    else if (cardList != null && cardList!.isNotEmpty)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Select card to payment',
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: cardList!.length,
                              itemBuilder: (context, index) {
                                final cardData = cardList![index].data()
                                    as Map<String, dynamic>;
                                final cardNumber =
                                    cardData['cardNumber'] ?? 'Unknown';

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedCard = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      child: ListTile(
                                        leading: Image.asset(
                                          'assets/images/master_card.png',
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        title: const Text(
                                          'Credit card',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          _formatCardNumber(cardNumber),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        trailing: Radio<int>(
                                          value: index,
                                          groupValue: selectedCard,
                                          onChanged: (int? value) {
                                            setState(() {
                                              selectedCard = value!;
                                            });
                                          },
                                          activeColor: Colors.orange,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    else
                      const Center(
                        child: Text(
                          'No cards found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Colors.orange,
                      indent: 25,
                      endIndent: 25,
                      thickness: 3,
                    ),
                    _buildDeliveryAddress(context, setState, cardList),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDeliveryAddress(BuildContext context, StateSetter setState,
      List<DocumentSnapshot>? cardList) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select delivery address',
            style: TextStyle(
              fontSize: 23,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              await getLocation(context, setState);
              setState(() {
                isLoading = false;
              });
            },
            child: Card(
              color: Colors.white,
              child: ListTile(
                leading: Image.asset(
                  'assets/images/delivery_man.png',
                ),
                title: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 35,
                    ),
                    Expanded(
                      child: isLoading
                          ? const Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.orange,
                                  strokeWidth: 3.0,
                                ),
                              ),
                            )
                          : Text(
                              deliveryAddress,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    getLocation(context, setState);
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            indent: 10,
            endIndent: 10,
            thickness: 3,
            color: Colors.orange,
          ),
          const SizedBox(height: 10),
          _buildDeliveryInfo('Delivery time:', '15-20 Min'),
          const SizedBox(height: 15),
          _buildDeliveryInfo('Delivery services:', '\$${widget.deliveryPrice}'),
          const SizedBox(height: 15),
          _buildDeliveryInfo('Total:', '\$${widget.total}'),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.orange,
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: MaterialButton(
              onPressed: () {
                if (cardList == null || cardList.isEmpty) {
                  showErrorCardDialog(context);
                } else if (deliveryAddress.isEmpty) {
                  showErrorDeliveryDialog(context);
                } else {
                  // Proceed with payment
                  showInvoiceDialog(context);
                }
              },
              child: const Text(
                'Make a payment',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showErrorDeliveryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Address Required',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Please select delivery address.',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showErrorCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'No Cards Found',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Please select your card',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeliveryInfo(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.orange,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final userId = _auth.currentUser?.uid;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        elevation: 5,
        onPressed: () async {
          final userId = FirebaseAuth.instance.currentUser?.uid;

          if (userId == null) {
            // Handle the case when userId is null
            customShowSnackBar(
              context: context,
              content: "User is not logged in.",
            );
            return;
          }
          final cartRef =
              FirebaseFirestore.instance.collection('carts').doc(userId);
          final cartSnapshot = await cartRef.get();
          final cartData = cartSnapshot.data() as Map<String, dynamic>?;

          if (cartData != null) {
            _showCheckoutBottomSheet(context, userId);
          } else {
            customShowSnackBar(
                context: context, content: 'No Products in Cart');
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Checkout',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
