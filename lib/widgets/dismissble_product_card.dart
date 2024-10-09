import 'package:flutter/material.dart';

class DismissibleProductCard extends StatelessWidget {
  final String itemId;
  final String productName;
  final String productImage;
  final String size;
  final double itemTotalPrice;
  final int quantity;
  final Future<void> Function(String itemId, String productName) deleteItem;
  final Future<void> Function(String itemId, int quantity, String size)
      updateItem;

  const DismissibleProductCard({
    Key? key,
    required this.itemId,
    required this.productName,
    required this.productImage,
    required this.size,
    required this.itemTotalPrice,
    required this.quantity,
    required this.deleteItem,
    required this.updateItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          return await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm Deletion"),
                content: Text(
                  "Are you sure you want to delete $productName?",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          );
        },
        onDismissed: (direction) async {
          await deleteItem(itemId, productName);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$productName was deleted'),
            ),
          );
        },
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: ListTile(
            leading: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: productImage.startsWith('http')
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          productImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.image, size: 120, color: Colors.black),
                    ),
            ),
            title: SizedBox(
              width: 30,
              child: Text(
                productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Size: $size'),
                const SizedBox(height: 5),
                Text('\$${itemTotalPrice.toStringAsFixed(2)}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    if (quantity > 1) {
                      updateItem(itemId, quantity - 1, size);
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        '-',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    updateItem(itemId, quantity + 1, size);
                  },
                  child: Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
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
          ),
        ),
      ),
    );
  }
}
