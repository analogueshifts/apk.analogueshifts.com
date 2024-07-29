import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/loading_dailog.dart';
import 'package:analogue_shifts_mobile/modules/uploads/presentation/changeNotifiers/upload_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

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
        context.read<FileUploadNotifier>().openImagePicker(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return Consumer<FileUploadNotifier>(
      builder: (context, FileUploadNotifier upload, child) =>
      InkWell(
      onTap: () async{
        await upload.openImagePicker(context);
      },
      child:
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffE8E8E8)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Upload logo',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextSemiBold('Supported file types: PNG, JPEG', color: isLight ? const Color(0xff525252) : const Color(0xff525252).withOpacity(0.9), fontSize: 10,),
              TextSemiBold('The file size can be up to 20MB', color: isLight ? const Color(0xff525252) : const Color(0xff525252).withOpacity(0.9), fontSize: 10,),
              const SizedBox(height: 16),
              // upload.isUploading == true ? CircularProgressIndicator(color: AppColors.primaryColor) :Text(""),
              if (upload.uploadedImage != null && upload.isUploading == false) ...[
                const SizedBox(height: 16),
                CachedNetworkImage(
                  imageUrl: upload.uploadedImage!,
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      minRadius: 50,
                      child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error, size: 50,),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}