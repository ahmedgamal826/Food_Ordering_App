// // // import 'package:flutter/material.dart';

// // // class FinancialScreen extends StatelessWidget {
// // //   final int orderCount;
// // //   final double totalPrice;

// // //   FinancialScreen({required this.orderCount, required this.totalPrice});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Financial Information'),
// // //         backgroundColor: Colors.orange,
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Text(
// // //               'Total Orders: $orderCount',
// // //               style: const TextStyle(
// // //                 fontSize: 24,
// // //                 fontWeight: FontWeight.bold,
// // //               ),
// // //             ),
// // //             const SizedBox(height: 20),
// // //             Text(
// // //               'Total Price: \$${totalPrice.toStringAsFixed(2)}',
// // //               style: const TextStyle(
// // //                 fontSize: 24,
// // //                 fontWeight: FontWeight.bold,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // class FinancialScreen extends StatefulWidget {
// //   FinancialScreen({required this.orderCount});

// //   int orderCount;
// //   @override
// //   _FinancialScreenState createState() => _FinancialScreenState();
// // }

// // class _FinancialScreenState extends State<FinancialScreen> {
// //   Map<String, double> dailyTotalPrices = {};

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchDailyTotalPrices();
// //   }

// //   Future<void> _fetchDailyTotalPrices() async {
// //     final snapshot =
// //         await FirebaseFirestore.instance.collection('cartsUser').get();

// //     // A map to store the total price for each day
// //     Map<String, double> totalsByDay = {};

// //     for (var doc in snapshot.docs) {
// //       final orderData = doc.data();
// //       final Timestamp? timestamp = orderData['timestamp'];
// //       final double totalPrice = orderData['total'] ?? 0.0;

// //       if (timestamp != null) {
// //         // Format the timestamp to a date string (e.g., '2024-09-08')
// //         final orderDate = DateFormat('yyyy-MM-dd').format(timestamp.toDate());

// //         // Accumulate the total price for each day
// //         if (totalsByDay.containsKey(orderDate)) {
// //           totalsByDay[orderDate] = totalsByDay[orderDate]! + totalPrice;
// //         } else {
// //           totalsByDay[orderDate] = totalPrice;
// //         }
// //       }
// //     }

// //     setState(() {
// //       dailyTotalPrices = totalsByDay;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Financial Information'),
// //         backgroundColor: Colors.orange,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: dailyTotalPrices.isEmpty
// //             ? const Center(child: CircularProgressIndicator())
// //             : ListView.builder(
// //                 itemCount: dailyTotalPrices.length,
// //                 itemBuilder: (context, index) {
// //                   final date = dailyTotalPrices.keys.elementAt(index);
// //                   final totalPrice = dailyTotalPrices[date]!;

// //                   return Card(
// //                     elevation: 5,
// //                     color: Colors.orange,
// //                     child: ListTile(
// //                       title: Text(
// //                         'Date: $date',
// //                         style: const TextStyle(
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       subtitle: Text(
// //                         'Total Price: \$${totalPrice.toStringAsFixed(2)}',
// //                         style: const TextStyle(
// //                           fontSize: 18,
// //                           color: Colors.black87,
// //                         ),
// //                       ),
// //                       trailing: Text('Total Orders: ${widget.orderCount}'),
// //                     ),
// //                   );
// //                 },
// //               ),
// //       ),
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class FinancialScreen extends StatefulWidget {
//   @override
//   _FinancialScreenState createState() => _FinancialScreenState();
// }

// class _FinancialScreenState extends State<FinancialScreen> {
//   Map<String, Map<String, dynamic>> dailyTotals = {};

//   @override
//   void initState() {
//     super.initState();
//     _fetchDailyTotals();
//   }

//   Future<void> _fetchDailyTotals() async {
//     final snapshot =
//         await FirebaseFirestore.instance.collection('cartsUser').get();

//     // A map to store the total price and order count for each day
//     Map<String, Map<String, dynamic>> totalsByDay = {};

//     for (var doc in snapshot.docs) {
//       final orderData = doc.data();
//       final Timestamp? timestamp = orderData['timestamp'];
//       final double totalPrice = orderData['total'] ?? 0.0;

//       if (timestamp != null) {
//         // Format the timestamp to a date string (e.g., '2024-09-08')
//         final orderDate = DateFormat('yyyy-MM-dd').format(timestamp.toDate());

//         // Check if the day already exists in the map
//         if (totalsByDay.containsKey(orderDate)) {
//           totalsByDay[orderDate]!['totalPrice'] += totalPrice;
//           totalsByDay[orderDate]!['orderCount'] += 1;
//         } else {
//           totalsByDay[orderDate] = {
//             'totalPrice': totalPrice,
//             'orderCount': 1,
//           };
//         }
//       }
//     }

//     setState(() {
//       dailyTotals = totalsByDay;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Sort the dates in descending order (newest to oldest)
//     final sortedDates = dailyTotals.keys.toList()
//       ..sort((a, b) => b.compareTo(a));
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         centerTitle: true,
//         title: const Text(
//           'Financial Management',
//           style: TextStyle(
//             fontSize: 25,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: dailyTotals.isEmpty
//             ? const Center(child: CircularProgressIndicator())
//             : ListView.builder(
//                 itemCount: sortedDates.length,
//                 itemBuilder: (context, index) {
//                   final date = dailyTotals.keys.elementAt(index);
//                   final dailyData = dailyTotals[date]!;
//                   final totalPrice = dailyData['totalPrice'] as double;
//                   final orderCount = dailyData['orderCount'] as int;

//                   return Card(
//                     color: Colors.orange,
//                     child: ListTile(
//                       title: Text(
//                         'Date: $date',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       subtitle: Text(
//                         'Total Orders: $orderCount\nTotal Price: \$${totalPrice.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinancialScreen extends StatefulWidget {
  @override
  _FinancialScreenState createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  Map<String, Map<String, dynamic>> dailyTotals = {};

  @override
  void initState() {
    super.initState();
    _fetchDailyTotals();
  }

  Future<void> _fetchDailyTotals() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('cartsUser').get();

    // A map to store the total price and order count for each day
    Map<String, Map<String, dynamic>> totalsByDay = {};

    for (var doc in snapshot.docs) {
      final orderData = doc.data();
      final Timestamp? timestamp = orderData['timestamp'];
      final double totalPrice = orderData['total'] ?? 0.0;

      if (timestamp != null) {
        // Format the timestamp to a date string (e.g., '2024-09-08')
        final orderDate = DateFormat('yyyy-MM-dd').format(timestamp.toDate());

        // Check if the day already exists in the map
        if (totalsByDay.containsKey(orderDate)) {
          totalsByDay[orderDate]!['totalPrice'] += totalPrice;
          totalsByDay[orderDate]!['orderCount'] += 1;
        } else {
          totalsByDay[orderDate] = {
            'totalPrice': totalPrice,
            'orderCount': 1,
          };
        }
      }
    }

    setState(() {
      dailyTotals = totalsByDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sort the dates in descending order (newest to oldest)
    final sortedDates = dailyTotals.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Money Management',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: dailyTotals.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
            : ListView.builder(
                itemCount: sortedDates.length,
                itemBuilder: (context, index) {
                  final date = sortedDates[index];
                  final dailyData = dailyTotals[date]!;
                  final totalPrice = dailyData['totalPrice'] as double;
                  final orderCount = dailyData['orderCount'] as int;

                  return Card(
                    color: Colors.orange,
                    child: ListTile(
                      title: Text(
                        'Date: $date',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'Total Orders: $orderCount\nTotal Price: \$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
