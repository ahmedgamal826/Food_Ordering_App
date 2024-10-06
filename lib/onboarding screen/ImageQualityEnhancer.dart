import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img; // مكتبة معالجة الصور
import 'package:image_cropper/image_cropper.dart'; // مكتبة قص الصور
import 'package:path_provider/path_provider.dart'; // للحصول على مسارات التخزين
import 'package:image_picker/image_picker.dart'; // لاختيار الصور

class ImageQualityEnhancer extends StatefulWidget {
  @override
  _ImageQualityEnhancerState createState() => _ImageQualityEnhancerState();
}

class _ImageQualityEnhancerState extends State<ImageQualityEnhancer> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> _enhanceImage() async {
    if (_image == null) return;

    // تحميل الصورة
    img.Image originalImage = img.decodeImage(await _image!.readAsBytes())!;

    // تحسين الجودة: قم بزيادة دقة الصورة
    img.Image enhancedImage = img.copyResize(originalImage,
        width: originalImage.width * 2, height: originalImage.height * 2);

    // حفظ الصورة المحسنة
    final directory = await getApplicationDocumentsDirectory();
    final enhancedImagePath = '${directory.path}/enhanced_image.png';
    File(enhancedImagePath).writeAsBytesSync(img.encodePng(enhancedImage));

    // عرض الصورة المحسنة
    setState(() {
      _image = File(enhancedImagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تحسين جودة الصورة'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null) Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('اختيار صورة'),
            ),
            ElevatedButton(
              onPressed: _enhanceImage,
              child: Text('تحسين الجودة'),
            ),
          ],
        ),
      ),
    );
  }
}
