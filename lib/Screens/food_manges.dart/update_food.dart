import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/text_field_add_food.dart';
import 'package:image_picker/image_picker.dart';

class UpdateFood extends StatefulWidget {
  UpdateFood({super.key, required this.docId, required this.foodData}) {}

  final String docId;
  final Map<String, dynamic> foodData;

  @override
  State<UpdateFood> createState() => _UpdateFoodState();
}

class _UpdateFoodState extends State<UpdateFood> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.foodData['name'] ?? '';
    priceController.text = widget.foodData['price'].toString() ?? '';
    // تحميل الصورة إذا كانت موجودة
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

    FirebaseFirestore.instance.collection('foods').doc(widget.docId).update({
      'name': nameController.text,
      'price': priceController.text,
      'image': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      print('Food is updated successfully');
      Navigator.pop(context);
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text(
          'Edit Food',
          style: TextStyle(
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
            child: Column(
              children: [
                TextFieledAddFood(
                  controller: nameController,
                  hinText: 'Food Name',
                ),
                const SizedBox(height: 20),
                TextFieledAddFood(
                  controller: priceController,
                  hinText: 'Food Price',
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: pickImage,
                  child: const Text('Pick Image'),
                ),
                if (image != null) Image.file(File(image!.path)),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: updateFood,
                  child: const Text(
                    'Edit Food',
                    style: TextStyle(
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
