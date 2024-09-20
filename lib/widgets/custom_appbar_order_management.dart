import 'package:flutter/material.dart';

class CustomAppbarOrderManagement extends StatelessWidget
    implements PreferredSizeWidget {
  final int orderCount;
  final double badgeSize;
  final Widget financialScreen;

  const CustomAppbarOrderManagement({
    Key? key,
    required this.orderCount,
    required this.badgeSize,
    required this.financialScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Text(''),
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
                    builder: (context) => financialScreen,
                  ),
                );
              },
              icon: const Icon(
                Icons.monetization_on,
                size: 40,
              ),
            ),
            if (orderCount > 0)
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
                      maxWidth: orderCount >= 1000 ? 50 : 30,
                      maxHeight: badgeSize,
                    ),
                    child: Center(
                      child: Text(
                        orderCount >= 1000 ? '999+' : '$orderCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: orderCount >= 1000 ? 10 : 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
