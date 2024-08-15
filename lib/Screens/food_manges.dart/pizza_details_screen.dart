import 'package:flutter/material.dart';

class PizzaDetailsScreen extends StatefulWidget {
  const PizzaDetailsScreen({super.key});

  @override
  State<PizzaDetailsScreen> createState() => _PizzaDetailsScreenState();
}

class _PizzaDetailsScreenState extends State<PizzaDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Pizza Details Screen'),
      ),
    );
  }
}
