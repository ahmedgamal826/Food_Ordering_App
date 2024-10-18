import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/constants_variables.dart';

class CustomImageOffers extends StatelessWidget {
  final String imageUrl;

  const CustomImageOffers({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.18,
      width: double.infinity,
      child: imageUrl.startsWith('http')
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.image,
                      size: 120,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            )
          : const Center(
              child: Icon(
                Icons.image,
                size: 120,
                color: Colors.black,
              ),
            ),
    );
  }
}
