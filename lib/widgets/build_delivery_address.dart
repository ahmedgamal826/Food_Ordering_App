import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/loading_dots.dart';

class BuildDeliveryAddress extends StatelessWidget {
  final String deliveryAddress;
  final bool isLoading;
  final Function() onEditAddress;
  final Function() onPayment;
  final double deliveryPrice;
  final double total;

  const BuildDeliveryAddress({
    Key? key,
    required this.deliveryAddress,
    required this.isLoading,
    required this.onEditAddress,
    required this.onPayment,
    required this.deliveryPrice,
    required this.total,
  }) : super(key: key);

  Widget _buildDeliveryInfo(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select delivery address',
            style: TextStyle(
              fontSize: 23,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: onEditAddress,
            child: Card(
              color: Colors.white,
              child: ListTile(
                leading: Image.asset(
                  'assets/images/delivery_man.png',
                ),
                title: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 35,
                    ),
                    Expanded(
                      child: isLoading
                          ? Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: SizedBox(
                                  height: 20, width: 20, child: LoadingDots()),
                            )
                          : Text(
                              deliveryAddress,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: onEditAddress,
                  icon: const Icon(
                    Icons.edit,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            indent: 10,
            endIndent: 10,
            thickness: 3,
            color: Colors.orange,
          ),
          const SizedBox(height: 10),
          _buildDeliveryInfo('Delivery time:', '15-20 Min'),
          const SizedBox(height: 15),
          _buildDeliveryInfo(
              'Delivery services:', '\$${deliveryPrice.toStringAsFixed(2)}'),
          const SizedBox(height: 15),
          _buildDeliveryInfo('Total:', '\$${total.toStringAsFixed(2)}'),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.orange,
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: MaterialButton(
              onPressed: onPayment,
              child: const Text(
                'Make a payment',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
