import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/user_home_page.dart';
import 'package:food_ordering_app/widgets/address_dialog.dart';
import 'package:food_ordering_app/widgets/build_delivery_address.dart';
import 'package:food_ordering_app/widgets/card_list_item.dart';
import 'package:food_ordering_app/widgets/credit_card_list.dart';
import 'package:food_ordering_app/widgets/delivery_dialog_error.dart';
import 'package:food_ordering_app/widgets/error_card_dialog.dart';
import 'package:food_ordering_app/widgets/invoice_dialog.dart';
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

    showDialog(
      context: context,
      builder: (context) => AddressDialog(
        address: _address,
        isLoading: isLoading,
        onViewMap: () {
          Navigator.of(context).pop();
          _navigateToMap(context, _currentLocation);
        },
        onClose: () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        },
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
      builder: (context) => InvoiceDialog(
        customerName: widget.customerName,
        items: widget.items,
        deliveryPrice: widget.deliveryPrice,
        total: widget.total,
        deliveryAddress: deliveryAddress,
        addToCart: addToCart,
        customShowSnackBar: customShowSnackBar,
      ),
    );
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
                          CreditCardListWidget(
                            cardList: cardList!,
                            selectedCard: selectedCard,
                            onCardSelected: (value) {
                              setState(() {
                                selectedCard = value!;
                              });
                            },
                          )
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

                    BuildDeliveryAddress(
                      deliveryAddress: deliveryAddress,
                      deliveryPrice: widget.deliveryPrice,
                      isLoading: isLoading,
                      onEditAddress: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await getLocation(context, setState);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      onPayment: () {
                        if (cardList == null || cardList!.isEmpty) {
                          ErrorCardDialogWidget.show(context);
                        } else if (deliveryAddress.isEmpty) {
                          DeliveryDialogError.show(context);
                        } else {
                          // Proceed with payment
                          showInvoiceDialog(context);
                        }
                      },
                      total: widget.total,
                    )
                    // _buildDeliveryAddress(context, setState, cardList),
                  ],
                ),
              ),
            );
          },
        );
      },
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
