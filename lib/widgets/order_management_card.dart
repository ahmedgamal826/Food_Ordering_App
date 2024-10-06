import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/showDeleteDialog_orderManagement.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderManagementCard extends StatelessWidget {
  final String userName;
  final String formattedTime;
  final Map<String, dynamic> order;
  final List<dynamic> items;
  final double total;
  final String documentId;
  //final Function(String) showDeleteDialog;
  final Future<void> Function() getOrderCount;
  final String? pendingDeleteDocumentId;

  const OrderManagementCard({
    Key? key,
    required this.userName,
    required this.formattedTime,
    required this.order,
    required this.items,
    required this.total,
    required this.documentId,
    required this.getOrderCount,
    this.pendingDeleteDocumentId,
  }) : super(key: key);

  void _openMap(String address) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          ListTile(
            title: Text(
              'Order by: $userName',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(right: 29),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      'Order Time: $formattedTime',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Address: ${order['deliveryAddress'] ?? 'Unknown'}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final address = order['deliveryAddress'] ?? 'Unknown';
                          _openMap(address); // Open map with the address
                        },
                        icon: const Icon(
                          size: 35,
                          Icons.location_pin,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          ...items.map((item) {
            final product = (item['product'] as Map<String, dynamic>?) ?? {};
            final productName = product['name'] as String? ?? '';
            final quantity = item['quantity'] as int? ?? 0;
            final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

            return Card(
              color: Colors.orange,
              margin: const EdgeInsets.all(8.0),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text(
                    productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '\$${itemTotalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery Services: \$20',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final shouldDelete = await showDeleteDialog(
                      context,
                      documentId,
                      getOrderCount,
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            indent: 25,
            endIndent: 25,
            color: Colors.white,
            thickness: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total: \$$total',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
