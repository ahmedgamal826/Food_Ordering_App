// lib/widgets/custom_grid_view.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/action_admin_buttons.dart';
import 'package:food_ordering_app/widgets/custom_name_category.dart';
import 'package:food_ordering_app/widgets/price_admin_category.dart';
import 'package:food_ordering_app/widgets/price_after_discount_admin.dart';
import 'package:food_ordering_app/widgets/price_and_favourite_button.dart';
import 'package:food_ordering_app/widgets/show_bottom_sheet.dart';
import 'package:food_ordering_app/widgets/user_category_card.dart';

class CustomGridView extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  final bool isAdmin;
  final List<bool> isFavouriteList;
  final Function resetValues;
  final Function customShowSnackBar;
  final Function showModalBottomSheet;
  final Map<String, double> sizeMultipliers;
  final CollectionReference foodRef;
  final String collectionName;

  const CustomGridView({
    Key? key,
    required this.documents,
    required this.isAdmin,
    required this.isFavouriteList,
    required this.resetValues,
    required this.customShowSnackBar,
    required this.showModalBottomSheet,
    required this.sizeMultipliers,
    required this.foodRef,
    required this.collectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
        final priceString = data['price'] as String ?? '0.0';
        final price = double.tryParse(priceString) ?? 0.0;
        final priceBeforeDiscountString = data['priceAfterDiscount'] ?? '0.0';
        final priceBeforeDiscount =
            double.tryParse(priceBeforeDiscountString) ?? 0.0;

        return InkWell(
          onTap: () {
            resetValues();

            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return CustomBottomSheet(
                  isAdmin: isAdmin,
                  description: description,
                  imageUrl: imageUrl,
                  name: name,
                  price: price,
                  sizeMultipliers: sizeMultipliers,
                );
              },
            );
          },
          child: isAdmin
              ? Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      collectionName == 'offers_category'
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
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
                      CustomNameCategory(name: name),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PriceAdminCategory(
                            collectionName: collectionName,
                            price: price,
                            priceBeforeDiscount: priceBeforeDiscount,
                          ),
                          const SizedBox(width: 10),
                          collectionName == 'offers_category'
                              ? PriceAfterDiscountAdmin(price: price)
                              : const SizedBox()
                        ],
                      ),
                      isAdmin
                          ? ActionAdminButtons(
                              collectionName: collectionName,
                              foodData: data,
                              docId: doc.id,
                              name: name,
                              onDelete: () {
                                foodRef.doc(doc.id).delete();
                                customShowSnackBar(
                                  context: context,
                                  content:
                                      '$name is deleted from $collectionName',
                                );
                              },
                            )
                          : PriceAndFavouriteButton(
                              description: description,
                              docId: doc.id,
                              imageUrl: imageUrl,
                              index: index,
                              isFavouriteList: isFavouriteList,
                              name: name,
                              price: price.toString(),
                            ),
                    ],
                  ),
                )
              : UserCategoryCard(
                  collectionName: collectionName,
                  description: description,
                  docId: doc.id,
                  imageUrl: imageUrl,
                  index: index,
                  isFavouriteList: isFavouriteList,
                  name: name,
                  price: price,
                  priceBeforeDiscount: priceBeforeDiscount,
                  discountOffer: discountOffer,
                ),
        );
      },
    );
  }
}
