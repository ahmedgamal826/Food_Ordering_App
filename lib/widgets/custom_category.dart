import 'package:flutter/material.dart';

class CustomCategory extends StatelessWidget {
  CustomCategory({
    super.key,
    required this.image,
    required this.categoryName,
    required this.onTap,
  });

  String image;
  String categoryName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 130,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 60,
                child: Image.asset(
                  image,
                ),
              ),
              Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                categoryName,
                style: const TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
