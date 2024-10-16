import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final bool isOut;

  const TitleSection({
    super.key,
    required this.title,
    required this.isOut,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Stack(
        children: [
          AnimatedPositioned(
            left: isOut
                ? MediaQuery.of(context).size.width + 100
                : (MediaQuery.of(context).size.width - 355) / 2,
            duration: const Duration(milliseconds: 250),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.orange,
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
