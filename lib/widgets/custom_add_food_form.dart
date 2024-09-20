import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/text_field_add_food.dart';
import 'package:image_picker/image_picker.dart';

class CustomAddFoodForm extends StatelessWidget {
  final bool isLoading;
  final bool isDrinkCategory;
  final bool isSweetCategory;
  final bool isOffersCategory;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController discountOfferController;
  final TextEditingController priceController;
  final TextEditingController priceBeforeDiscountController;
  final VoidCallback pickImage;
  final VoidCallback updateFood;
  final XFile? image;

  const CustomAddFoodForm({
    Key? key,
    required this.isLoading,
    required this.isDrinkCategory,
    required this.isSweetCategory,
    required this.isOffersCategory,
    required this.nameController,
    required this.descriptionController,
    required this.discountOfferController,
    required this.priceController,
    required this.priceBeforeDiscountController,
    required this.pickImage,
    required this.updateFood,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              // Food Name Field
              TextFieledAddFood(
                controller: nameController,
                hinText: isDrinkCategory
                    ? 'Drink Name'
                    : isSweetCategory
                        ? 'Sweet Name'
                        : isOffersCategory
                            ? 'Offer Name'
                            : 'Food Name',
              ),
              const SizedBox(height: 20),

              // Food Description Field
              TextFieledAddFood(
                controller: descriptionController,
                hinText: isDrinkCategory
                    ? 'Drink Description'
                    : isSweetCategory
                        ? 'Sweet Description'
                        : isOffersCategory
                            ? 'Offer Description'
                            : 'Food Description',
              ),
              const SizedBox(height: 20),

              // Discount Offer Field (only for offers)
              if (isOffersCategory)
                TextFieledAddFood(
                  controller: discountOfferController,
                  hinText: 'Offer Discount',
                ),
              if (isOffersCategory) const SizedBox(height: 20),

              // Price Before Discount
              TextFieledAddFood(
                controller: priceBeforeDiscountController,
                hinText: isDrinkCategory
                    ? 'Drink Price'
                    : isSweetCategory
                        ? 'Sweet Price'
                        : isOffersCategory
                            ? 'Offer Price'
                            : 'Food Price',
              ),
              const SizedBox(height: 20),

              // Price After Discount (only for offers)
              if (isOffersCategory)
                TextFieledAddFood(
                  controller: priceController,
                  hinText: 'Offer Price After Discount',
                ),
              if (isOffersCategory) const SizedBox(height: 20),

              // Pick Image Button
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

              // Display selected image
              if (image != null) Image.file(File(image!.path)),

              const SizedBox(height: 50),

              // Edit Button
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
                          : isOffersCategory
                              ? 'Edit Offer'
                              : 'Edit Food',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Loading Indicator
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          ),
      ],
    );
  }
}
