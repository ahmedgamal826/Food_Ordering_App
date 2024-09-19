import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/finanicial_managmenet_screen.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:intl/intl.dart';

class OrdersManagment extends StatefulWidget {
  @override
  State<OrdersManagment> createState() => _OrdersManagmentState();
}

class _OrdersManagmentState extends State<OrdersManagment> {
  String? _pendingDeleteDocumentId;
  int _orderCount = 0; // Store the number of orders

  @override
  void initState() {
    super.initState();
    _getOrderCount();
  }

  Future<void> showDeleteDialog(BuildContext context, String documentId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Order'),
          content: const Text('Are you sure you want to delete this order?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () async {
                    if (_pendingDeleteDocumentId != null) {
                      await FirebaseFirestore.instance
                          .collection('cartsUser')
                          .doc(documentId)
                          .delete();

                      await _getOrderCount();
                    }
                    Navigator.of(context).pop(true);
                    customShowSnackBar(
                        context: context,
                        content: 'Order Deleted Successfully!');
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
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
  }

  Future<void> _getOrderCount() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('cartsUser').get();
    setState(() {
      _orderCount = snapshot.docs.length;
    });
  }

  Future<String> getUserName(String userId) async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('user_app')
        .doc(userId)
        .get();
    return userSnapshot.data()?['name'] ?? 'Unknown User';
  }

  @override
  Widget build(BuildContext context) {
    // Calculate badge size based on order count
    final badgeSize = _orderCount > 9 ? 30.0 : 24.0;
    final badgeTextSize = _orderCount > 9 ? 12.0 : 10.0;

    double totalPrice = 0;
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Orders Management',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinancialScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.monetization_on,
                  size: 40,
                ),
              ),
              if (_orderCount > 0)
                Positioned(
                  right: 0,
                  child: ClipOval(
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: _orderCount >= 1000 ? 50 : 30,
                        maxHeight: badgeSize,
                      ),
                      child: Center(
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return Text(
                              _orderCount >= 1000 ? '999+' : '$_orderCount',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: _orderCount >= 1000 ? 10 : 12,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cartsUser')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.orange));
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            );
          }

          final orders = snapshot.data?.docs ?? [];

          if (orders.isEmpty) {
            return const Center(
              child: Text(
                'No orders found.',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index].data() as Map<String, dynamic>;
              final documentId = orders[index].id;
              final items = (order['items'] as List<dynamic>?) ?? [];
              final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
              final formattedTime = timestamp != null
                  ? DateFormat('yyyy-MM-dd – hh:mm a').format(timestamp)
                  : 'Unknown Time';
              final userId = order['userId'] as String?;

              final total = order['total'];

              return FutureBuilder<String>(
                future: getUserName(userId ?? ''),
                builder: (context, userSnapshot) {
                  final userName = userSnapshot.data ?? '';

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
                                Text(
                                  textAlign: TextAlign.start,
                                  'Address: ${order['deliveryAddress'] ?? 'Unknown'}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ...items.map((item) {
                          final product =
                              (item['product'] as Map<String, dynamic>?) ?? {};
                          final productName = product['name'] as String? ?? '';
                          final quantity = item['quantity'] as int? ?? 0;
                          final itemTotalPrice =
                              item['totalPrice'] as double? ?? 0.0;

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
                                  setState(() {
                                    _pendingDeleteDocumentId = documentId;
                                  });
                                  final shouldDelete = await showDeleteDialog(
                                      context, documentId);
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
                },
              );
            },
          );
        },
      ),
    );
  }
}
