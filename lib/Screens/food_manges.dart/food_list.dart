import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/loading_dots.dart';
import 'package:food_ordering_app/models/products_food.dart';
import 'package:food_ordering_app/widgets/custom_grid_view.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

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
          return Center(child: LoadingDots());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong: ${snapshot.error}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              widget.searchQuery.isNotEmpty
                  ? 'No results found for "${widget.searchQuery}".'
                  : 'No items available.',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.orange,
              ),
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
            CustomGridView(
              documents: documents,
              isAdmin: isAdmin,
              isFavouriteList: isFavouriteList,
              resetValues: resetValues,
              customShowSnackBar: customShowSnackBar,
              showModalBottomSheet: showModalBottomSheet,
              sizeMultipliers: sizeMultipliers,
              foodRef: foodRef,
              collectionName: widget.collectionName,
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
