import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class BurgerDetails extends StatefulWidget {
  const BurgerDetails({super.key});

  @override
  State<BurgerDetails> createState() => _BurgerDetailsState();
}

class _BurgerDetailsState extends State<BurgerDetails> {
  int counter = 1;

  String selectedValue = 'option';

  final List<Product> products = [
    Product('Chicken(\$2.00)', 2.00),
    Product('Beef(\$3.00)', 3.00),
    Product('Paprika(\$2.00)', 2.00),
    Product('Cheese(\$2.00)', 2.00),
    Product('Pickle(\$2.00)', 2.00),
    Product('Angus Beef(\$5.00)', 5.00),
    Product('Potato(\$2.00)', 2.00),
    Product('Broccoli(\$2.00)', 2.00),
    Product('Onion(\$2.00)', 2.00),
    Product('Fries(\$4.00)', 4.00),
  ];

  final Map<Product, double> selectedProducts = {};
  double _totalPrice = 0.0;

  void getTotalPrice() {
    double totalPrice = 0.0;
    for (var entry in selectedProducts.entries) {
      final product = entry.key;
      final quantity = entry.value;
      totalPrice += product.price * quantity;
    }
    setState(() {
      _totalPrice = totalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 30, color: Colors.orange),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 20,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border_outlined,
                  size: 23,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.asset(
            height: 200,
            'assets/images/burger_details.png',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Beef Burger',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text('⭐⭐⭐⭐⭐ 5.0(490)'),
                Row(
                  children: [
                    Text(
                      '\$',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '10.00',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (counter > 1) {
                                  counter--;
                                }
                              });
                            },
                            child: Container(
                              color: Colors.orange,
                              width: 30,
                              height: 30,
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$counter',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                counter++;
                              });
                            },
                            child: Container(
                              color: Colors.orange,
                              width: 30,
                              height: 30,
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  child: Text(
                    textAlign: TextAlign.justify,
                    ''' A beef burger is a type of hamburger made with ground beef as the primary ingredient.Beef burgers are served on a bun and can be customized with a variety of toppings.''',
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                ),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Center the column
                      children: [
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Size',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        RadioListTile(
                          title: Text(
                            'Normal-200g(\$9.00)',
                          ), // Define text and value directly
                          value: 'option1',
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                              print("Selected Value = $selectedValue");
                            });
                          },
                        ),
                        // Add more RadioListTile widgets as needed for other options
                        RadioListTile(
                          title: Text('Double-400g(\$12.00)'),
                          value: 'option2',
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                              print("Selected Value = $selectedValue");
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    'Choise of add on',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return CheckboxListTile(
                        title: Text(product.name),
                        value: selectedProducts.containsKey(product),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value!) {
                              // Add or increment product quantity
                              selectedProducts[product] =
                                  (selectedProducts[product] ?? 0) + 1;
                            } else {
                              // Remove product or decrement quantity
                              if (selectedProducts[product] == 1) {
                                selectedProducts.remove(product);
                              } else {
                                selectedProducts[product];
                              }
                            }
                            getTotalPrice(); // Recalculate total price
                          });
                        },
                      );
                    },
                  ),
                ),
                Align(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () {},
                    child: Text(
                      'Add To Cart',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                Text('Total Price: $_totalPrice'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
