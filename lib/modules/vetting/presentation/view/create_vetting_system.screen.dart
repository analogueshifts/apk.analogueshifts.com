import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/custom_single_chile_scroll_view.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/vetting/presentation/widgets/text_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:googleapis/streetviewpublish/v1.dart';

class CreateVettingScreen extends StatefulWidget {
  const CreateVettingScreen({super.key});

  @override
  State<CreateVettingScreen> createState() => _CreateVettingScreenState();
}

class _CreateVettingScreenState extends State<CreateVettingScreen> with SingleTickerProviderStateMixin  {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 1; // Set initial tab to Preview
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final _isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return Scaffold(
      appBar: PaylonyAppBarTwo(title: "Vetting System"),
      body: Column(
        children: [
          TabBar(

            controller: _tabController,
            tabs: [
              Tab(text: 'Create'),
              Tab(text: 'Preview'),
            ],
            labelColor: _isLight ?Color(0xff0F2942) : AppColors.white,
            unselectedLabelColor: _isLight ? Color(0xff0F2942).withOpacity(0.46) : AppColors.white,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 5.0, color: AppColors.primaryColor),
              insets: EdgeInsets.symmetric(horizontal: 0.0),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CreateForm(),
                PreviewForm()
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CreateForm extends StatefulWidget {
  const CreateForm({super.key});

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomSingleChildScrollView(
          child: Column(
            children: [
              Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Row(
                      children: [
                        TextSemiBold("Add question", color: AppColors.primaryColor,),
                        Icon(Icons.add, color: AppColors.primaryColor,)
                      ],
                    ),
                  )
                ],
              ),
              Gap(20),
              SizedBox(
                height: 220.h,
                  child: TextEditor())
            ],
          ),
        ),
      ),
    );
  }
}

class PreviewForm extends StatefulWidget {
  const PreviewForm({super.key});

  @override
  State<PreviewForm> createState() => _PreviewFormState();
}

class _PreviewFormState extends State<PreviewForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return CustomSingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              Center(child: TextBold("Form 1", fontSize: 20, color:  _isLight ? AppColors.background : AppColors.white, textAlign: TextAlign.center,)),
              Gap(20),
              TextSemiBold(
                "Full Name",
                color: _isLight ? AppColors.background : AppColors.white,
                fontWeight: FontWeight.w700,),
              const Gap(6),
              TextFormField(
                // controller: _emailController,
                decoration: textInputDecoration.copyWith(
                    fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                    ),
                    hintText: 'e.g  Sam Donald'),
                validator: (value) {
                  if (value == null) return ("Enter your email");

                  return null;
                },
                onChanged: (value) {
                },
              ),
              Gap(20),
              TextSemiBold(
                "Date of birth",
                color: _isLight ? AppColors.background : AppColors.white,
                fontWeight: FontWeight.w700,),
              const Gap(6),
              TextFormField(
                // controller: _emailController,
                decoration: textInputDecoration.copyWith(
                    fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                    ),
                    hintText: 'e.g  2/1/2023'),
                validator: (value) {
                  if (value == null) return ("Enter your date of birth");

                  return null;
                },
                onChanged: (value) {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

