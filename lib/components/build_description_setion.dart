import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  final String description;
  final bool isOut;

  const DescriptionSection({
    super.key,
    required this.description,
    required this.isOut,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Stack(
        children: [
          AnimatedPositioned(
            right: isOut ? MediaQuery.of(context).size.width + 100 : 0,
            duration: const Duration(milliseconds: 250),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 19, 54, 33),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
