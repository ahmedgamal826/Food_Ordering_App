import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_ordering_app/Screens/favourite_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';
import 'package:food_ordering_app/Screens/order_screen.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

// class Product {
//   final String name;
//   final double price;

//   Product(this.name, this.price);
// }

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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<bool> isFavouriteList = [];
  List<Map<String, dynamic>> favourites = [];

  int counter = 1;
  String selectedSize = ''; // Default size
  final Map<String, double> sizeMultipliers = {
    'Small': 1.0,
    'Medium': 1.5,
    'Large': 2.0,
  };
  final List<String> burgerSizes = ['Small', 'Medium', 'Large'];

  // final Map<String, bool> selectedExtras = {};
  double _totalPrice = 0.0;

  final Map<ProductFoods, double> selectedProducts =
      {}; // Define selectedProducts

  // void calculateTotalPrice(double basePrice) {
  //   double totalPrice = basePrice;
  //   // for (var entry in selectedExtras.entries) {
  //   //   if (entry.value) {
  //   //     // Extract price from the extra string
  //   //     final price = double.parse(entry.key.split('\$')[1].split(')')[0]);
  //   //     totalPrice += price;
  //   //   }
  //   // }
  //   totalPrice *= counter;
  //   setState(() {
  //     _totalPrice = totalPrice;
  //   });
  // }

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
        String role = adminDoc.get('rool'); // Fix the field name here
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

  void resetValues() {
    setState(() {
      counter = 1;
      selectedSize = '';
      _totalPrice = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final CollectionReference foodRef =
        FirebaseFirestore.instance.collection(widget.collectionName);

    final String lowercaseQuery = widget.searchQuery.toLowerCase();

    // Update all documents to ensure they have 'name_lowercase'
    updateAllDocuments(foodRef);

    // Determine the stream based on whether there is a search query
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
        // Initialize isFavouriteList with the same length as documents
        isFavouriteList = List<bool>.filled(documents.length, false);

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
            GridView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
                childAspectRatio: 0.6, // Adjust for your aspect ratio needs
              ),
              shrinkWrap: true,
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final doc = documents[index];
                final data = doc.data() as Map<String, dynamic>;
                final imageUrl = data['image'] as String? ?? '';
                final name = data['name'] as String? ?? '';
                final description = data['description'] as String? ?? '';
                final discountOffer = data['offerDiscount'] as String? ?? '';
                //final price = data['price'];
                final priceString = data['price'] as String ?? '0.0';
                final price = double.tryParse(priceString) ?? 0.0;

                final priceBeforeDiscountString =
                    data['priceAfterDiscount'] ?? '0.0';
                final priceBeforeDiscount =
                    double.tryParse(priceBeforeDiscountString) ?? 0.0;

                return InkWell(
                  onTap: () {
                    resetValues();
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        double widthScreen = MediaQuery.of(context).size.width;
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Container(
                            height: screenHeight * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                          border: Border.all(
                                              color: Colors.white,
                                              width:
                                                  2), // Optional: Add a border if desired
                                        ),
                                        child: imageUrl.startsWith('http')
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Ensure the border radius matches
                                                child: Image.network(
                                                  imageUrl,
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
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Text(
                                                name,
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
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              '⭐⭐⭐⭐⭐',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
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
                                      SizedBox(
                                        width: widthScreen * 0.35,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (counter > 0) {
                                              counter--;
                                              calculateTotalPrice(price);
                                            }
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '$counter',
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            counter++;
                                            calculateTotalPrice(price);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Size',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: widthScreen * 0.2,
                                      ),
                                      Wrap(
                                        spacing: 5,
                                        children: sizeMultipliers.keys.map(
                                          (size) {
                                            return ChoiceChip(
                                              label: Text(size),
                                              selected: selectedSize == size,
                                              onSelected: (selected) {
                                                setState(() {
                                                  selectedSize = size;
                                                  calculateTotalPrice(price);
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Padding(
                                    padding: const EdgeInsets.only(left: 5),
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
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5),
                                      child: Text(
                                        description,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  isAdmin
                                      ? Text('')
                                      : ElevatedButton(
                                          onPressed: () async {
                                            // Handle Add to Cart
                                            final product = ProductFoods(
                                                name, price, imageUrl);

                                            // Generate a unique ID for the cart item
                                            final cartItemId = FirebaseFirestore
                                                .instance
                                                .collection('carts')
                                                .doc()
                                                .id;

                                            // Save the cart items to Firestore
                                            final user = FirebaseAuth
                                                .instance.currentUser;
                                            if (user != null) {
                                              final cartRef = FirebaseFirestore
                                                  .instance
                                                  .collection('carts')
                                                  .doc(user.uid);

                                              // Check if the cart document exists
                                              final cartDoc =
                                                  await cartRef.get();
                                              if (cartDoc.exists) {
                                                // Update the cart document
                                                await cartRef.update({
                                                  'items':
                                                      FieldValue.arrayUnion([
                                                    {
                                                      'id': cartItemId,
                                                      'product':
                                                          product.toMap(),
                                                      'quantity': counter,
                                                      'size': selectedSize,
                                                      'totalPrice': _totalPrice,
                                                    }
                                                  ])
                                                });
                                              } else {
                                                // Create a new cart document
                                                await cartRef.set({
                                                  'items': [
                                                    {
                                                      'id': cartItemId,
                                                      'product':
                                                          product.toMap(),
                                                      'quantity': counter,
                                                      'image': imageUrl,
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
                                                builder: (context) => OrderScreen(

                                                    // cartItems: selectedProducts,
                                                    ),
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
                                              padding:
                                                  const EdgeInsets.all(10)),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                  // Admin
                  child: isAdmin
                      ? Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.collectionName == 'offers_category'
                                  ? Stack(
                                      children: [
                                        SizedBox(
                                          height: 115,
                                          width: double.infinity,
                                          child: imageUrl.startsWith('http')
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    // height: 100,
                                                    // width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    imageUrl,
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
                                        Container(
                                          width: 40,
                                          color: Colors.red,
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            '${discountOffer}%',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : SizedBox(
                                      height: 115,
                                      width: double.infinity,
                                      child: imageUrl.startsWith('http')
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                // height: 100,
                                                // width: double.infinity,
                                                fit: BoxFit.cover,
                                                imageUrl,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    child: widget.collectionName ==
                                            'offers_category'
                                        ? Text(
                                            textAlign: TextAlign.center,
                                            '\$${priceBeforeDiscount}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            textAlign: TextAlign.center,
                                            '\$${price.toString()}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  widget.collectionName == 'offers_category'
                                      ? SizedBox(
                                          width: 60,
                                          child: Text(
                                            '\$${price}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                              isAdmin
                                  ? Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateFood(
                                                    docId: doc.id,
                                                    foodData: data,
                                                    collectionName:
                                                        widget.collectionName,
                                                    categoryName: '',
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.orange,
                                                    title: const Text(
                                                      'Confirm Delete',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    content: Text(
                                                      'Are you sure you want to delete $name?',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.white,
                                                            ),
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.white,
                                                            ),
                                                            child: const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              // Perform the delete operation
                                                              foodRef
                                                                  .doc(doc.id)
                                                                  .delete();
                                                              customShowSnackBar(
                                                                context:
                                                                    context,
                                                                content:
                                                                    '$name is deleted from ${widget.collectionName}',
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the dialog after delete
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '\$$price',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange,
                                              ),
                                              overflow: TextOverflow
                                                  .ellipsis, // Ensure text doesn't overflow
                                              maxLines:
                                                  2, // Limit the number of lines
                                            ),
                                          ),
                                          StatefulBuilder(
                                            builder: (context, setState) {
                                              return IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    isFavouriteList[index] =
                                                        !isFavouriteList[index];
                                                  });

                                                  final user = FirebaseAuth
                                                      .instance.currentUser;
                                                  if (user != null) {
                                                    final userId = user.uid;

                                                    final docRef = FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(userId)
                                                        .collection(
                                                            'favourites')
                                                        .doc(doc
                                                            .id); // Use user ID to create or reference the document

                                                    // final docRef = FirebaseFirestore
                                                    //     .instance
                                                    //     .collection('favourites')
                                                    //     .doc(doc.id);

                                                    if (isFavouriteList[
                                                        index]) {
                                                      // Add to favourites
                                                      await docRef.set({
                                                        'name': name,
                                                        'price': price,
                                                        'imageUrl': imageUrl,
                                                        'description':
                                                            description,
                                                        'timestamp': FieldValue
                                                            .serverTimestamp(),
                                                      });
                                                    } else {
                                                      // Remove from favourites
                                                      await docRef.delete();
                                                    }
                                                  }

                                                  customShowSnackBar(
                                                    context: context,
                                                    content:
                                                        '$name is added to favourites',
                                                  );
                                                },
                                                icon: Icon(
                                                  isFavouriteList[index]
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: isFavouriteList[index]
                                                      ? Colors.red
                                                      : Colors.black,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        )
                      // User
                      : Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.collectionName == 'offers_category'
                                  ? Stack(
                                      children: [
                                        SizedBox(
                                          height: 115,
                                          width: double.infinity,
                                          child: imageUrl.startsWith('http')
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    // height: 100,
                                                    // width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    imageUrl,
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
                                        Container(
                                          width: 40,
                                          color: Colors.red,
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            '${discountOffer}%',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : SizedBox(
                                      height: 140,
                                      width: double.infinity,
                                      child: imageUrl.startsWith('http')
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                // height: 100,
                                                // width: double.infinity,
                                                fit: BoxFit.cover,
                                                imageUrl,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 50),
                                        child: widget.collectionName ==
                                                'offers_category'
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30),
                                                child: Text(
                                                  '\$$priceBeforeDiscount',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                  overflow: TextOverflow
                                                      .ellipsis, // Ensure text doesn't overflow
                                                  // maxLines: 2,
                                                ),
                                              )
                                            : Text(
                                                '\$$price',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange,
                                                ),
                                                overflow: TextOverflow
                                                    .ellipsis, // Ensure text doesn't overflow
                                                // maxLines: 2,
                                              ),
                                      ),
                                    ),
                                    widget.collectionName == 'offers_category'
                                        ? Expanded(
                                            child: Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 50),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30),
                                                child: Text(
                                                  '\$$price',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                  ),
                                                  overflow: TextOverflow
                                                      .ellipsis, // Ensure text doesn't overflow
                                                  // maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Text(''),
                                    widget.collectionName != 'offers_category'
                                        ? StatefulBuilder(
                                            builder: (context, setState) {
                                              return IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    isFavouriteList[index] =
                                                        !isFavouriteList[index];
                                                  });

                                                  final user = FirebaseAuth
                                                      .instance.currentUser;
                                                  if (user != null) {
                                                    final userId = user.uid;

                                                    final docRef = FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(userId)
                                                        .collection(
                                                            'favourites')
                                                        .doc(doc
                                                            .id); // Use user ID to create or reference the document

                                                    // final docRef = FirebaseFirestore
                                                    //     .instance
                                                    //     .collection('favourites')
                                                    //     .doc(doc.id);

                                                    if (isFavouriteList[
                                                        index]) {
                                                      // Add to favourites
                                                      await docRef.set({
                                                        'name': name,
                                                        'price': price,
                                                        'imageUrl': imageUrl,
                                                        'description':
                                                            description,
                                                        'timestamp': FieldValue
                                                            .serverTimestamp(),
                                                      });
                                                    } else {
                                                      // Remove from favourites
                                                      await docRef.delete();
                                                    }
                                                  }

                                                  customShowSnackBar(
                                                    context: context,
                                                    content:
                                                        '$name is added to favourites',
                                                  );
                                                },
                                                icon: Icon(
                                                  isFavouriteList[index]
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: isFavouriteList[index]
                                                      ? Colors.red
                                                      : Colors.black,
                                                ),
                                              );
                                            },
                                          )
                                        : Text('')
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

  void updateAllDocuments(CollectionReference collectionRef) async {
    final docs = await collectionRef.get();
    for (final doc in docs.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final name = data['name'] as String? ?? '';
      await doc.reference.update({
        'name_lowercase': name.toLowerCase(),
      });
    }
  }
}
