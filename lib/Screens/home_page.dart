// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/widgets/Special_offers_list_view.dart';
// import 'package:food_ordering_app/widgets/category_list_view.dart';
// import 'package:food_ordering_app/widgets/my_drawer.dart';
// import 'package:food_ordering_app/widgets/search_textform_field.dart';
// import 'package:food_ordering_app/widgets/special_food_list_view.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String name = '';
//   String email = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   _loadUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       name = prefs.getString('name') ?? '';
//       email = prefs.getString('emailLogin') ?? '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF1F5F9),
//       drawer: MyDrawer(
//         name: name,
//         email: email,
//       ),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: const Color(0xffF1F5F9),
//         iconTheme: const IconThemeData(color: Colors.black, size: 30),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 15),
//             child: CircleAvatar(
//               backgroundImage: AssetImage('assets/images/ahmed.jpg'),
//               radius: 20,
//             ),
//           ),
//         ],
//       ),
//       body: ListView(
//         physics: const BouncingScrollPhysics(),
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome $name 👋 ',
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 ),
//                 const Text(
//                   "Let's eat",
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                 ),
//                 const Text(
//                   'Nutrious food.',
//                   style: TextStyle(fontSize: 30),
//                 )
//               ],
//             ),
//           ),
//           SearchTextformField(
//             hintText: 'Search your food...',
//           ),
//           const CategoryListView(),
//           const SizedBox(
//             height: 30,
//           ),
//           SpecialFoodListView(),
//           const SpecialOffersListView()
//         ],
//       ),
//     );
//   }
// }
