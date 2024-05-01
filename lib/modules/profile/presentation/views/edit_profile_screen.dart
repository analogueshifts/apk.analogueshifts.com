import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PaylonyAppBarTwo(title: "Edit Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: [
            const Image(image: AssetImage("assets/images/Avatar Image.png"), width: 60, height: 60,),
            const Gap(8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.file_upload_outlined),
                Gap(6),
                Text("Edit Image"),
              ],
            ),
            const Gap(20),
              TextSemiBold("Name", style: Theme.of(context).textTheme.bodyMedium,),
              const Gap(6),
              TextFormField(
                controller: _nameController,
                decoration: textInputDecoration.copyWith(
                    hintText: 'John James'),
                validator: (value) {
                  if (value == null) return ("Enter your name");
                  if (CustomValidator.validEmail(value.trim()) == false)
                    return ("Invalid name");

                  return null;
                },
                onChanged: (value) {
                },
              ),
            const Gap(20),
              TextSemiBold("Email", style: Theme.of(context).textTheme.bodyMedium,),
              const Gap(6),
              TextFormField(
                controller: _emailController,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Enter your email address'),
                validator: (value) {
                  if (value == null) return ("Enter your email");
                  if (CustomValidator.validEmail(value.trim()) == false)
                    return ("Invalid email");

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
                    hintText: '07062881214'),
                validator: (value) {
                  if (value == null) return ("Enter your email");
                  if (CustomValidator.validEmail(value.trim()) == false)
                    return ("Invalid email");

                  return null;
                },
                onChanged: (value) {
                },
              ),
              const Gap(35),
              BusyButton(title: "Save", onTap:() {
                
              },)
          ],
        ),
        ),
    );
  }
}