import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/validator.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ForgotPasswordView extends StatefulWidget {
  final String? email;
  const ForgotPasswordView({super.key, this.email});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.email == null)return;
    _emailController.text = widget.email.toString();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (_, auth, __) {
      return AbsorbPointer(
        absorbing: auth.authState.isGenerating,
        child: Scaffold(
          appBar: PaylonyAppBarTwo(
            title: "",
            centerTitle: false,
          ),
          body: Consumer<UserViewModel>(
            builder: (_, auth, __) {
           return SingleChildScrollView(
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
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,
                    ),
                    const Gap(5),
                    TextSemiBold(
                        'Don’t worry! It occurs. Please enter the email address linked with your account.', color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.6) : Color(0xff909090) ,),
                    const Gap(30),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: textInputDecoration.copyWith(
                           fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.06) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.25) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                            hintText: 'Enter your email'),
                        validator: (value) {
                          if (value == null) return ("Enter your email");
                          if (CustomValidator.validEmail(value.trim()) == false) {
                            return ("Invalid email");
                          }
            
                          return null;
                        },
                        onChanged: (value) {
                          if(_formKey.currentState == null)return;
                          _formKey.currentState!.validate();
                        },
                      ),
                    ),
                    const Gap(60),
                    BusyButton(
                        title: "Send Code",
                        textColor: Colors.white,
                        isLoading: auth.authState.isGenerating,
                        height: 58,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            auth.forgetPassword(_emailController.text.trim(), context);
                          }
                        }),
                  ],
                ));
            }
          ),
        ),
      );
      }
    );
  }
}
