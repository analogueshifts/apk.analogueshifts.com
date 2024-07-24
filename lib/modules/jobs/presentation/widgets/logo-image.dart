import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class LogoUploadWidget extends StatefulWidget {
  @override
  _LogoUploadWidgetState createState() => _LogoUploadWidgetState();
}

class _LogoUploadWidgetState extends State<LogoUploadWidget> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getImage,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffE8E8E8)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Upload logo',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            TextSemiBold('Supported file types: PNG, JPEG', color: Color(0xff525252), fontSize: 10,),
            TextSemiBold('The file size can be up to 20MB', color: Color(0xff525252), fontSize: 10,),
            SizedBox(height: 16),
            if (_image != null) ...[
              SizedBox(height: 16),
              Image.file(_image!),
            ],
          ],
        ),
      ),
    );
  }
}