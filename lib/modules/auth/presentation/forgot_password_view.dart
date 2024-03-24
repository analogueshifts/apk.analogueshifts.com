import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaylonyAppBarTwo(
        title: "",
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(
                20,
              ),
              TextBold(
                'Forgot Password?',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              const Gap(5),
              TextSemiBold(
                  'Don’t worry! It occurs. Please enter the email address linked with your account.'),
              const Gap(30),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailController,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Enter your email'),
                  validator: (value) {
                    if (value == null) return ("Enter your email");
                    if (CustomValidator.validEmail(value.trim()) == false)
                      return ("Invalid email");

                    return null;
                  },
                ),
              ),
              const Gap(60),
              BusyButton(
                  title: "Send Code",
                  textColor: Colors.white,
                  height: 58,
                  onTap: () {}),
            ],
          )),
    );
  }
}
