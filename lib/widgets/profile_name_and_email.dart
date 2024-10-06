import 'package:flutter/material.dart';

class ProfileNameAndEmail extends StatelessWidget {
  const ProfileNameAndEmail({super.key, required this.authService});

  final authService;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          '${authService.userName ?? 'loading...'}',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          '${authService.userEmail ?? 'loading...'}',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
