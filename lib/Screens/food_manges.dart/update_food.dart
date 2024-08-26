import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:food_ordering_app/widgets/text_field_add_food.dart';
import 'package:image_picker/image_picker.dart';

class UpdateFood extends StatefulWidget {
  UpdateFood({
    super.key,
    required this.docId,
    required this.foodData,
    required this.collectionName,
    required this.categoryName,
  }) {}

  final String collectionName;
  final String categoryName;
  final String docId;
  final Map<String, dynamic> foodData;

  @override
  State<UpdateFood> createState() => _UpdateFoodState();
}

class _UpdateFoodState extends State<UpdateFood> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.foodData['name'] ?? '';
    descriptionController.text = widget.foodData['description'] ?? '';
    priceController.text = widget.foodData['price'].toString() ?? '';
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedFile;
    });
  }

  Future<String?> uploadImage(XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('images/${image!.name}');
      // final imageRef = storageRef.child(
      //     'images/${DateTime.now().millisecondsSinceEpoch}_${image.name}');
      final uploadTask = imageRef.putFile(File(image.path));

      final snapshot = await uploadTask;
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> updateFood() async {
    setState(() {
      isLoading = true; // عرض دائرة التحميل
    });
    final imageUrl =
        image != null ? await uploadImage(image!) : widget.foodData['image'];

    // FirebaseFirestore.instance.collection('foods').doc(widget.docId).update({
    //   'name': nameController.text,
    //   'price': priceController.text,
    //   'image': imageUrl, // رابط الصورة
    // });
    // Navigator.pop(context);

    FirebaseFirestore.instance
        .collection(widget.collectionName)
        .doc(widget.docId)
        .update({
      'name': nameController.text,
      'description': descriptionController.text,
      'price': priceController.text,
      'image': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      print('Food is updated successfully');
      Navigator.pop(context);
      customShowSnackBar(
        context: context,
        content:
            '${nameController.text} is updated in ${widget.collectionName}',
      );
    }).catchError((error) {
      print("Failed to update food: $error");
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDrinkCategory = widget.collectionName == 'tea category' ||
        widget.collectionName == 'coffee category' ||
        widget.collectionName == 'lemonade category' ||
        widget.collectionName == 'orange juice category' ||
        widget.collectionName == 'water category' ||
        widget.collectionName == 'pepsi category' ||
        widget.collectionName == 'strawberry juice category';

    final isSweetCategory = widget.collectionName == 'ice cream category' ||
        widget.collectionName == 'donuts category' ||
        widget.collectionName == 'waffle category' ||
        widget.collectionName == 'chocolate cake category' ||
        widget.collectionName == 'Cupcake category';

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          isDrinkCategory
              ? 'Edit Drink'
              : isSweetCategory
                  ? 'Edit Sweet'
                  : 'Edit Food',
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
              children: [
                TextFieledAddFood(
                  controller: nameController,
                  hinText: isDrinkCategory
                      ? 'Drink Name'
                      : isSweetCategory
                          ? 'Sweet Name'
                          : 'Food Name',
                ),
                const SizedBox(height: 20),
                TextFieledAddFood(
                  controller: descriptionController,
                  hinText: isDrinkCategory
                      ? 'Drink Description'
                      : isSweetCategory
                          ? 'Sweet Description'
                          : 'Food Description',
                ),
                const SizedBox(height: 20),
                TextFieledAddFood(
                  controller: priceController,
                  hinText: isDrinkCategory
                      ? 'Drink Price'
                      : isSweetCategory
                          ? 'Sweet Price'
                          : 'Food Price',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: pickImage,
                  child: const Text(
                    'Pick Image',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (image != null) Image.file(File(image!.path)),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: updateFood,
                  child: Text(
                    isDrinkCategory
                        ? 'Edit Drink'
                        : isSweetCategory
                            ? 'Edit Sweet'
                            : 'Edit Food',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
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
