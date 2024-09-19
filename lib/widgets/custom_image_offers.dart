import 'package:flutter/material.dart';

class CustomImageOffers extends StatelessWidget {
  final String imageUrl;

  const CustomImageOffers({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: imageUrl.startsWith('http')
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                fit: BoxFit.cover,
                imageUrl,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
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
