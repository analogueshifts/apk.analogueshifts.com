import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/authenticate_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AuthSuccessScreen extends StatefulWidget {
  final String title;
  final String subtTitle;
  const AuthSuccessScreen({super.key, required this.title, required this.subtTitle});

  @override
  State<AuthSuccessScreen> createState() => _AuthSuccessScreenState();
}

class _AuthSuccessScreenState extends State<AuthSuccessScreen> {

  final DBService _db = getIt<DBService>();
  String? token;

  @override
  void initState() {
    token = _db.getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(height: 100.h, width: 100.w, Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/Sticker.png" : "assets/icons/Sticker-dark.png"),
              Gap(20),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,
                  fontWeight: FontWeight.w700
                ),
              ),
              Gap(15),
              Text(
                widget.subtTitle,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 14,
                  color: Color(0xff909090),
                  fontWeight: FontWeight.w400
                ),
              ),
              Gap(40),
              BusyButton(title: "Enter", onTap: () async{
                logger.d('running from myself');
                
                if (token == null) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.authenticate,
                        (Route<dynamic> route) => false);
                }else{
       
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.homeNavigation,
                          (Route<dynamic> route) => false);
                }
               
              },)

            ],
          ),
        ),
      ),
    );
  }
}