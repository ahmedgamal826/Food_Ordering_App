// // import 'dart:io';

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:food_ordering_app/widgets/text_field_add_food.dart';
// // import 'package:image_picker/image_picker.dart';

// // class AddFoodPage extends StatefulWidget {
// //   AddFoodPage({super.key});

// //   @override
// //   State<AddFoodPage> createState() => _AddFoodPageState();
// // }

// // class _AddFoodPageState extends State<AddFoodPage> {
// //   final TextEditingController nameController = TextEditingController();
// //   final TextEditingController priceController = TextEditingController();
// //   final ImagePicker imagePicker = ImagePicker();
// //   XFile? image; // لحفظ الصورة التي يتم اختيارها
// //   bool isLoading = false;

// //   Future<void> pickImage() async {
// //     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
// //     setState(() {
// //       image = pickedFile;
// //     });
// //   }

// //   Future<String?> uploadImage(XFile image) async {
// //     try {
// //       final storageRef = FirebaseStorage.instance.ref();
// //       final imageRef = storageRef.child('images/${image!.name}');
// //       // final imageRef = storageRef.child(
// //       //     'images/${DateTime.now().millisecondsSinceEpoch}_${image.name}');
// //       final uploadTask = imageRef.putFile(File(image.path));

// //       final snapshot = await uploadTask;
// //       final imageUrl = await snapshot.ref.getDownloadURL();
// //       return imageUrl;
// //     } catch (e) {
// //       print("Error uploading image: $e");
// //       return null;
// //     }
// //   }

// //   Future<void> addFood() async {
// //     setState(() {
// //       isLoading = true; // عرض دائرة التحميل
// //     });

// //     String? imageUrl;

// //     if (image != null) {
// //       imageUrl = await uploadImage(image!);
// //     }

// //     FirebaseFirestore.instance.collection('foods').add({
// //       'name': nameController.text,
// //       'price': priceController.text,
// //       'image': imageUrl,
// //       'timestamp': FieldValue.serverTimestamp(),
// //     }).then((_) {
// //       print('Food is added successfully');
// //       Navigator.pop(context);
// //     }).catchError((error) {
// //       print("Failed to add food: $error");
// //     }).whenComplete(() {
// //       setState(() {
// //         isLoading = false; // إخفاء دائرة التحميل
// //       });
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         iconTheme: const IconThemeData(color: Colors.white),
// //         centerTitle: true,
// //         backgroundColor: Colors.orange,
// //         title: const Text(
// //           'Add Food',
// //           style: TextStyle(
// //             fontSize: 23,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),

// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: ListView(
// //           physics: const BouncingScrollPhysics(),
// //           children: [
// //             TextFieledAddFood(
// //               controller: nameController,
// //               hinText: 'Food Name',
// //             ),
// //             const SizedBox(height: 20),
// //             TextFieledAddFood(
// //               controller: priceController,
// //               hinText: 'Food Price',
// //             ),
// //             const SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: pickImage,
// //               child: const Text('Pick Image'),
// //             ),
// //             if (image != null) Image.file(File(image!.path)),
// //             const SizedBox(height: 50),
// //             ElevatedButton(
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.orange,
// //               ),
// //               onPressed: addFood,
// //               child: const Text(
// //                 'Add Food',
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/widgets/text_field_add_food.dart';
// import 'package:image_picker/image_picker.dart';

// class AddFoodPage extends StatefulWidget {
//   AddFoodPage({super.key});

//   @override
//   State<AddFoodPage> createState() => _AddFoodPageState();
// }

// class _AddFoodPageState extends State<AddFoodPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final ImagePicker imagePicker = ImagePicker();
//   XFile? image; // لحفظ الصورة التي يتم اختيارها
//   bool isLoading = false;

//   Future<void> pickImage() async {
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       image = pickedFile;
//     });
//   }

//   Future<String?> uploadImage(XFile image) async {
//     try {
//       final storageRef = FirebaseStorage.instance.ref();
//       final imageRef = storageRef.child('images/${image!.name}');
//       final uploadTask = imageRef.putFile(File(image.path));

//       final snapshot = await uploadTask;
//       final imageUrl = await snapshot.ref.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       print("Error uploading image: $e");
//       return null;
//     }
//   }

//   Future<void> addFood() async {
//     setState(() {
//       isLoading = true; // عرض دائرة التحميل
//     });

//     String? imageUrl;

//     if (image != null) {
//       imageUrl = await uploadImage(image!);
//     }

//     FirebaseFirestore.instance.collection('foods').add({
//       'name': nameController.text,
//       'price': priceController.text,
//       'image': imageUrl,
//       'timestamp': FieldValue.serverTimestamp(),
//     }).then((_) {
//       print('Food is added successfully');
//       Navigator.pop(context);
//     }).catchError((error) {
//       print("Failed to add food: $error");
//     }).whenComplete(() {
//       setState(() {
//         isLoading = false; // إخفاء دائرة التحميل
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//         title: const Text(
//           'Add Food',
//           style: TextStyle(
//             fontSize: 23,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: ListView(
//               physics: const BouncingScrollPhysics(),
//               children: [
//                 TextFieledAddFood(
//                   controller: nameController,
//                   hinText: 'Food Name',
//                 ),
//                 const SizedBox(height: 20),
//                 TextFieledAddFood(
//                   controller: priceController,
//                   hinText: 'Food Price',
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: pickImage,
//                   child: const Text('Pick Image'),
//                 ),
//                 if (image != null) Image.file(File(image!.path)),
//                 const SizedBox(height: 50),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                   ),
//                   onPressed: addFood,
//                   child: const Text(
//                     'Add Food',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (isLoading)
//             const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.orange,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:food_ordering_app/widgets/text_field_add_food.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodPage extends StatefulWidget {
  final String collectionName;

  AddFoodPage({super.key, required this.collectionName});

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
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
      'price': priceController.text,
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text(
          'Add Food',
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
            child: ListView(
              physics: const BouncingScrollPhysics(),
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: addFood,
                  child: const Text(
                    'Add Food',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
