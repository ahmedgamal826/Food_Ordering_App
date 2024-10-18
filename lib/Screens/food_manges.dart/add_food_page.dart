import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:food_ordering_app/widgets/text_field_add_food.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodPage extends StatefulWidget {
  final String collectionName;
  final String categoryName; // إضافة المتغير الجديد

  AddFoodPage({
    super.key,
    required this.collectionName,
    required this.categoryName,
  });

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController priceBeforeDiscountController =
      TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  XFile? image; // لحفظ الصورة التي يتم اختيارها
  bool isLoading = false;

  Future<void> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedFile;
    });
  }

  Future<String?> uploadImage(XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('images/${image.name}');
      final uploadTask = imageRef.putFile(File(image.path));

      final snapshot = await uploadTask;
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> addFood() async {
    setState(() {
      isLoading = true; // عرض دائرة التحميل
    });

    String? imageUrl;

    if (image != null) {
      imageUrl = await uploadImage(image!);
    }

    FirebaseFirestore.instance.collection(widget.collectionName).add({
      'name': nameController.text,
      'description': descriptionController.text,
      'price': priceController.text,
      'priceAfterDiscount': priceBeforeDiscountController.text,
      'offerDiscount': discountController.text,
      'image': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      print('Food is added successfully');
      Navigator.pop(context);
      customShowSnackBar(
          context: context,
          content:
              '${nameController.text} is added to ${widget.collectionName}');
    }).catchError((error) {
      print("Failed to add food: $error");
    }).whenComplete(() {
      setState(() {
        isLoading = false; // إخفاء دائرة التحميل
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDrinkCategory = widget.categoryName == 'Drinks';
    final isFoodCategory = widget.categoryName == 'Foods';
    final isSweetCategory = widget.categoryName == 'Sweets';
    final isOffersCategory = widget.categoryName == 'Offers';

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          isDrinkCategory
              ? 'Add Drink'
              : isFoodCategory
                  ? 'Add Food'
                  : isSweetCategory
                      ? 'Add Sweet'
                      : 'Add Offers',
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                TextFieledAddFood(
                  controller: nameController,
                  hinText: isDrinkCategory
                      ? 'Drink Name'
                      : isFoodCategory
                          ? 'Food Name'
                          : isOffersCategory
                              ? 'Offer Name'
                              : 'Sweet Name',
                ),
                const SizedBox(height: 20),
                TextFieledAddFood(
                  controller: descriptionController,
                  hinText: isDrinkCategory
                      ? 'Drink Description'
                      : isFoodCategory
                          ? 'Food Description'
                          : isOffersCategory
                              ? 'Offer Description'
                              : 'Sweet Description',
                ),
                const SizedBox(height: 20),
                isOffersCategory
                    ? TextFieledAddFood(
                        controller: discountController,
                        hinText: isDrinkCategory
                            ? 'Drink Price'
                            : isFoodCategory
                                ? 'Food Price'
                                : isOffersCategory
                                    ? 'Offer Discount'
                                    : 'Sweet Price',
                      )
                    : const SizedBox(height: 10),
                const SizedBox(height: 20),
                isOffersCategory
                    ? TextFieledAddFood(
                        controller: priceBeforeDiscountController,
                        hinText: isDrinkCategory
                            ? 'Drink Price'
                            : isFoodCategory
                                ? 'Food Price'
                                : isOffersCategory
                                    ? 'Offer Price Before Discount'
                                    : 'Sweet Price',
                      )
                    : const SizedBox(height: 20),
                const SizedBox(height: 20),
                TextFieledAddFood(
                  controller: priceController,
                  hinText: isDrinkCategory
                      ? 'Drink Price'
                      : isFoodCategory
                          ? 'Food Price'
                          : isOffersCategory
                              ? 'Offer Price After Discount'
                              : 'Sweet Price',
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                MaterialButton(
                  color: Colors.orange,
                  onPressed: pickImage,
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Pick Image',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (image != null) Image.file(File(image!.path)),
                const SizedBox(height: 50),
                MaterialButton(
                  color: Colors.orange,
                  onPressed: addFood,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      isDrinkCategory
                          ? 'Add Drink'
                          : isFoodCategory
                              ? 'Add Food'
                              : isOffersCategory
                                  ? 'Add Offer'
                                  : 'Add Sweet',
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
        ],
      ),
    );
  }
}
