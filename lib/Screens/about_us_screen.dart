import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'About Us',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              textAlign: TextAlign.center,
              'Welcome to Foodies Ordering!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'At Foodies Delivery, we are dedicated to providing you with the best food delivery experience. Our team is passionate about delivering high-quality meals from our local restaurant right to your doorstep.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Our Mission:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'To make food delivery convenient, quick, and enjoyable for everyone. We strive to connect people with delicious meals and exceptional service.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Our Services:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Fast and reliable delivery.\n• Wide selection of local restaurants.\n• Easy and secure payment options.\n• Exceptional customer support.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Text(
              'Contact With Us:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              'Email: ahmedelnemrtiger592@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Phone: 01011904241',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.facebook,
                    color: Colors.blue,
                    size: 50,
                  ),
                  onPressed: () {
                    _launchURL(
                        'https://www.facebook.com/profile.php?id=100037702272055&mibextid=ZbWKwL');
                  },
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    _launchURL('https://www.instagram.com/ahmedelnemr2022/#');
                  },
                  child: Image.asset(
                    'assets/images/instagram.png',
                    width: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.orange,
              thickness: 2,
              indent: 30,
              endIndent: 30,
            ),
            const Divider(
              color: Colors.orange,
              thickness: 2,
              indent: 60,
              endIndent: 60,
            ),
            const Divider(
              color: Colors.orange,
              thickness: 2,
              indent: 100,
              endIndent: 100,
            ),
            const Divider(
              color: Colors.orange,
              thickness: 2,
              indent: 150,
              endIndent: 150,
            ),
          ],
        ),
      ),
    );
  }
}
