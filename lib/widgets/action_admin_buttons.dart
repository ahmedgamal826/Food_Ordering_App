import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';
import 'package:food_ordering_app/widgets/custom_dialog.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class ActionAdminButtons extends StatelessWidget {
  final String docId;
  final Map<String, dynamic> foodData;
  final String collectionName;
  final String name;
  final Function onDelete;

  const ActionAdminButtons({
    Key? key,
    required this.docId,
    required this.foodData,
    required this.collectionName,
    required this.name,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateFood(
                    docId: docId,
                    foodData: foodData,
                    collectionName: collectionName,
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
                builder: (context) {
                  return CustomDialog(
                    name: name,
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onConfirm: () {
                      onDelete();
                      customShowSnackBar(
                        context: context,
                        content: '$name is deleted from $collectionName',
                      );
                      Navigator.of(context)
                          .pop(); // Close the dialog after delete
                    },
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
    );
  }
}
