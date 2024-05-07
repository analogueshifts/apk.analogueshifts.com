import 'dart:math';

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/core/utils/validator.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/uploads/presentation/changeNotifiers/upload_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    final user = context.read<UserViewModel>().authState.user;
    final upload = context.read<FileUploadNotifier>();
    _nameController.text = user?.name ?? "";
    _emailController.text = user?.email ?? "";
    _phoneController.text = user?.tel ?? "";
    // if (mounted) {
    //    upload.setUploadedImage(user?.profile ?? "");
    // }
   
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer2<UserViewModel, FileUploadNotifier>(
      builder: (context, UserViewModel user, FileUploadNotifier upload, child) {
      return AbsorbPointer(
        absorbing: user.authState.isGenerating || upload.isUploading == true,
        child: Scaffold(
          appBar: const PaylonyAppBarTwo(title: "Edit Profile"),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListView(
              children: [
                user.authState.user?.profile == null && upload.uploadedImage == null ? const Icon(Icons.verified_user) : CachedNetworkImage(
                  imageUrl: upload.uploadedImage ?? user.authState.user?.profile ?? "",
                  placeholder: (context, url) => CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    minRadius: 50,
                    child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error, size: 50,),
                ),
                const Gap(8),
                TouchableOpacity(
                  onTap: () {
                    upload.openImagePicker(context);
                  },
                  child: upload.isUploading == true ? SizedBox(
                    width: 10.w,
                    height: 5.h,
                    child: const LinearProgressIndicator(
                      minHeight: 5,
                    )) : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_upload_outlined),
                      Gap(6),
                      Text("Edit Image"),
                    ],
                  ),
                ),
                const Gap(20),
                  TextSemiBold("Name", style: Theme.of(context).textTheme.bodyMedium,),
                  const Gap(6),
                  TextFormField(
                    controller: _nameController,
                    decoration: textInputDecoration.copyWith(
                      fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                        hintText: user.authState.user?.name ?? 'John James'),
                    validator: (value) {
                      if (value == null) return ("Enter your name");
                      if (CustomValidator.validEmail(value.trim()) == false) {
                        return ("Invalid name");
                      }
        
                      return null;
                    },
                    onChanged: (value) {
                    },
                  ),
                const Gap(20),
                  TextSemiBold("Email", style: Theme.of(context).textTheme.bodyMedium,),
                  const Gap(6),
                  TextFormField(
                    enabled: false,
                    controller: _emailController,
                    decoration: textInputDecoration.copyWith(
                      fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                        hintText: user.authState.user?.email ?? ''),
                    validator: (value) {
                      if (value == null) return ("Enter your email");
                      if (CustomValidator.validEmail(value.trim()) == false) {
                        return ("Invalid email");
                      }
        
                      return null;
                    },
                    onChanged: (value) {
                    },
                  ),
                  const Gap(15),
                  TextSemiBold("Phone Number", style: Theme.of(context).textTheme.bodyMedium,),
                  const Gap(6),
                  TextFormField(
                    controller: _phoneController,
                    decoration: textInputDecoration.copyWith(
                      fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                        hintText: user.authState.user?.tel ?? "Update Phone Number"),
                    validator: (value) {
                      if (value == null) return ("Enter your email");
                      if (CustomValidator.validEmail(value.trim()) == false) {
                        return ("Invalid email");
                      }
        
                      return null;
                    },
                    onChanged: (value) {
                    },
                  ),
                  const Gap(35),
                  BusyButton(title: "Save", isLoading: user.authState.isGenerating, onTap:() {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                          currentFocus.focusedChild?.unfocus();
                        }
                    final savedUser = user.authState.user;
                    if(savedUser?.profile == null && upload.uploadedImage == null){
                      if(!mounted)return;
                       AppSnackbar.error(context, message: "Update your profile image");
                    }else{
                       user.updateUser(User(id: savedUser?.id, uuid: savedUser?.uuid, name: _nameController.text, username: savedUser?.username ?? Random().nextInt(100).toString(), email: savedUser?.email, tel: _phoneController.text, role: savedUser?.role, profile: upload.uploadedImage ?? savedUser?.profile, otp: "", isVerified: savedUser?.isVerified, googleToken: "", emailVerifiedAt: "", createdAt: savedUser?.createdAt, updatedAt: savedUser?.updatedAt), context);
                    }
                   
                  },)
              ],
            ),
            ),
        ),
      );
      }
    );
  }
}