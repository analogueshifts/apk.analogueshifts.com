import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/validator.dart';
import 'package:analogue_shifts_mobile/modules/Event/data/models/create-event.dto.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/change_notifier/event.notifier.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/widgets/step.dart';
import 'package:analogue_shifts_mobile/modules/uploads/presentation/changeNotifiers/upload_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEventStepForm extends StatefulWidget {
  @override
  _CreateEventStepFormState createState() => _CreateEventStepFormState();
}

class _CreateEventStepFormState extends State<CreateEventStepForm> {
  final PageController _pageController = PageController();
  int _currentPage = 1;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _startDate;
  String? _endDate;
  DateTime _startDateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.brightness;
    return Scaffold(
      appBar: const PaylonyAppBarTwo(title: "Create Events"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            StepIndicator(currentStep: _currentPage, totalSteps: 3),
            _currentPage == 1 ? _buildStep1() : _currentPage == 2 ? _buildStep2() : _buildStep3(context)
          ],
        ),
      ),
    );
  }

   bool isFormValid(){
    bool value = false;
     setState(() {
       if(_formKey.currentState == null)return;

       if(_formKey.currentState!.validate() == true){
         value = true;
       }else{
         value = false;
       }

     });

     return value;
   }
   
   String? _endDateError;
  String? _startDateError;

  bool isFormValid2(){
    bool value = false;
    setState(() {
      if(_formKey2.currentState == null)return;

      if(_formKey2.currentState!.validate() == true && _endDate != null && _startDate != null){
        value = true;
      }else{
        value = false;
        
      }

    });

    return value;
  }


  Widget _buildStep1() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(35),
            TextSemiBold('Your Email Address', fontSize: 12, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFonts.manRope)),
            const Gap(4),
            TextSemiBold('Attendees will contact you via this email for any questions.',color: const Color(0xff575757),fontSize: 12, fontWeight: FontWeight.w400),
            const Gap(6),
            TextFormField(
              controller: _emailController,
              decoration: textInputDecoration.copyWith(
                  fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.06) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.4)
                  ),
                  hintText: 'john@gmail.com'),
              validator: (value) {
                if (value == null) return ("Enter your email");
                if (value.isEmpty) return ("Enter your email");
                if(CustomValidator.validEmail(value) == false)return ("Email is not valid");
                return null;
              },
              onChanged: (value) {
                isFormValid();
              },
            ),
            const Gap(20),
            TextSemiBold('Phone Number', fontSize: 12, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFonts.manRope)),
            const Gap(4),
            TextSemiBold('Attendees will contact you via this number for any questions..',color: const Color(0xff575757),fontSize: 12, fontWeight: FontWeight.w400),
            const Gap(6),
            TextFormField(
              controller: _phoneController,
              decoration: textInputDecoration.copyWith(
                  fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.06) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.4)
                  ),
                  hintText: '+234 90456323421'),
              validator: (value) {
                if (value == null) return ("Enter your email");
                if (value.isEmpty) return ("Enter your phone");
                return null;
              },
              onChanged: (value) {
                isFormValid();
              },
            ),
            const Gap(20),
            TextSemiBold('Event Title', fontSize: 12, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFonts.manRope)),
            const Gap(4),
            TextSemiBold('Use a clear, descriptive title to tell people about your event.',color: const Color(0xff575757),fontSize: 12, fontWeight: FontWeight.w400),
            const Gap(6),
            TextFormField(
              controller: _titleController,
              decoration: textInputDecoration.copyWith(
                  fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.06) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.4)
                  ),
                  hintText: 'Event Title'),
              validator: (value) {
                if (value == null) return ("Enter your email");
                if (value.isEmpty) return ("Enter your title");
                return null;
              },
              onChanged: (value) {
                isFormValid();
              },
            ),
            const Gap(20),
            TextSemiBold('Event Summary', fontSize: 12, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFonts.manRope)),
            const Gap(4),
            TextSemiBold('Grab attention with a description of your event.',color: const Color(0xff575757),fontSize: 12, fontWeight: FontWeight.w400),
            const Gap(6),
            TextFormField(
              controller: _summaryController,
              maxLines: 7,
              decoration: textInputDecoration.copyWith(
                  fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.06) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.4)
                  ),
                  hintText: 'Attendees will see this at the top of your event page.'),
              validator: (value) {
                if (value == null) return ("Enter your email");
                if (value.isEmpty) return ("Enter your phone");
                return null;
              },
              onChanged: (value) {
                isFormValid();
              },
            ),
            const Gap(20),
            TextSemiBold('Event Price', fontSize: 12, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFonts.manRope)),
            const Gap(4),
            TextSemiBold("Enter a price for this event ticket. Use '0' if it's free.",color: const Color(0xff575757), fontSize: 12, fontWeight: FontWeight.w400),
            const Gap(6),
            TextFormField(
              controller: _priceController,
              decoration: textInputDecoration.copyWith(
                  fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.06) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.4)
                  ),
                  hintText: 'Event Price'),
              validator: (value) {
                if (value == null) return ("Enter your email");
                if (value.isEmpty) return ("Enter your price");
                return null;
              },
              onChanged: (value) {
                isFormValid();

              },
            ),
            const Gap(5),
            TextSemiBold("Please Note that Prices are in USD..",color: const Color(0xff575757),fontSize: 12, fontWeight: FontWeight.w400),
            const Gap(40),
            BusyButton(
                title: "Next",
                disabled: isFormValid() == true ? false: true,
                onTap: (){
              if(isFormValid()){
                setState(() {
                  _currentPage = 2;
                });
              }
            }),

            const Gap(30)
          ],
        ),
      ),
    );
  }

  bool _isOnline = false;

  Widget _buildStep2() {
    final theme = Theme.of(context).colorScheme.brightness;
    return SingleChildScrollView(
      child: Form(
        key: _formKey2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Gap(20),
            TextSemiBold('Start Date',fontSize: 12, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFonts.manRope)),
            const Gap(4),
            TextSemiBold('Enter The date and Time your event starts.',color: const Color(0xff575757), fontSize: 12, fontWeight: FontWeight.w400),
            const Gap(6),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                ).then((selectedDate) {
                  // After selecting the date, display the time picker.
                  if (selectedDate != null) {
                    showTimePicker(
                      context: context,
                      initialEntryMode: TimePickerEntryMode.input,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      // Handle the selected date and time here.
                      if (selectedTime != null) {
                        DateTime selectedDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                        );
                        String formattedDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(selectedDateTime);
                        setState(() {
                          _startDate = formattedDateTime.toString();
                          _startDateTime = selectedDateTime;
                        });
                        print(formattedDateTime);
                      }
                    });
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                width: double.infinity,
                // height: 56,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffE5E5E5)),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextSemiBold(_startDate  == null ? "dd/mm/yy" : _startDate.toString(),color: _startDate == null ? const Color(0xff000000).withOpacity(0.40) : theme == Brightness.light ? AppColors.background : AppColors.white,),
                    TextSemiBold(_startDateError ?? "", color: Colors.red, fontSize: 12,)
                  ],
                ),
              ),
            ),
            const Gap(20),
            TextSemiBold('End Date', fontSize: 12, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFonts.manRope)),
            const Gap(4),
            TextSemiBold('Enter The date and Time your event ends.',color: const Color(0xff575757), fontSize: 12, fontWeight: FontWeight.w400),
            const Gap(6),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: _startDateTime,
                  firstDate: _startDateTime,
                  lastDate: DateTime(2101),
                ).then((selectedDate) {
                  // After selecting the date, display the time picker.
                  if (selectedDate != null) {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      // Handle the selected date and time here.
                      if (selectedTime != null) {
                        DateTime selectedDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                        String formattedDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(selectedDateTime);
                        setState(() {
                          _endDate = formattedDateTime.toString();
                        });
                        // _endDate = Functions.getFormattedDate(selectedDateTime);
                        print(formattedDateTime); // You can use the selectedDateTime as needed.
                      }
                    });
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                width: double.infinity,
                // height: 56,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffE5E5E5)),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextSemiBold(_endDate  == null ? "dd/mm/yy" : _endDate.toString(),color: _endDate == null ? const Color(0xff000000).withOpacity(0.40) : theme == Brightness.light ? AppColors.background : AppColors.white,),
                    TextSemiBold(_endDateError ?? "", color: Colors.red, fontSize: 12,)
                  ],
                ),
              ),
            ),
            const Gap(20),
            TextSemiBold('Event Location', fontSize: 12, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFonts.manRope)),
            const Gap(4),
            TextSemiBold("Use a clear, descriptive title to tell people about your event.",color: const Color(0xff575757), fontSize: 12, fontWeight: FontWeight.w400,),
            const Gap(10),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      _isOnline = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10
                    ),
                    decoration: BoxDecoration(
                      color: _isOnline == true ?  const Color(0xffFFFAEB) : AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: TextSemiBold("Venue", color: _isOnline == true ? AppColors.primaryColor : AppColors.white,),
                  ),
                ),
                const Gap(12),
                InkWell(
                  onTap: (){
                    setState(() {
                      _isOnline = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10
                    ),
                    decoration: BoxDecoration(
                        color: _isOnline == false ? const Color(0xffFFFAEB) : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(25)

                    ),
                    child: TextSemiBold("Online Meeting", color:  _isOnline == true ? AppColors.white : AppColors.primaryColor,),
                  ),
                ),
              ],
            ),
            const Gap(20),
            TextSemiBold('Address', fontSize: 12, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFonts.manRope)),
            const Gap(4),
            TextSemiBold("Enter your physical location For your Event.",color: const Color(0xff575757), fontSize: 12, fontWeight: FontWeight.w400,),
            const Gap(6),
            TextFormField(
              controller: _addressController,
              decoration: textInputDecoration.copyWith(
                  fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.06) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.18)
                      )
                  ),
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.4)
                  ),
                  hintText: 'Enter Location'),
              validator: (value) {
                if (value == null) return ("Enter your location");
                if (value.isEmpty) return ("Enter your location");
                return null;
              },
              onChanged: (value) {
                isFormValid();

              },
            ),
            const Gap(40),
            BusyButton(
                title: "Next",
                disabled: isFormValid2() == true ? false: true,
                onTap: (){
                  if(isFormValid2()){
                    setState(() {
                      _currentPage = 3;
                    });
                  }
                }),

            const Gap(30)
          ],
        ),
      ),
    );
  }

  Widget _buildStep3(BuildContext context) {
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    // Implement step 3 form fields
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(30),
        TextSemiBold("Upload Event Cover Photo", fontSize: 12, fontWeight: FontWeight.w600,),
        const Gap(8),
        Consumer<FileUploadNotifier>(
          builder: (context, FileUploadNotifier upload, child) =>
              InkWell(
                onTap: () async{
                  var value = await upload.SelectAndUploadImage(context);
                  setState(() {
                    if(value != null){
                      logger.d(value);
                      imageUrl = value;
                      _currentPage = 4;
                      logger.d(imageUrl);
                    }

                  });
                },
                child:
                Container(
                  width: double.infinity,
                  height: 100.h,
                  decoration: BoxDecoration(
                    border: imageUrl == null ? Border.all(color: const Color(0xffE8E8E8)) : Border.all(color: const Color(0xff039855)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: imageUrl != null ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Successfully uploaded',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff039855)
                        ),
                      ),
                      const Gap(4),
                      SvgPicture.asset("assets/icons/checkmark-circle-03.svg")
                    ],
                  ) :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Upload logo',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                           color: imageUrl != null  ? const Color(0xff039855) : isLight ? AppColors.background : AppColors.white
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextSemiBold('Supported file types: PNG, JPEG', color: imageUrl != null ? const Color(0xff039855) : isLight ? const Color(0xff525252) : const Color(0xff525252).withOpacity(0.5), fontSize: 10,),
                      TextSemiBold('The file size can be up to 20MB', color: imageUrl != null ? const Color(0xff039855) : isLight ? const Color(0xff525252) : const Color(0xff525252).withOpacity(0.5), fontSize: 10,),
                      // upload.isUploading == true ? CircularProgressIndicator(color: AppColors.primaryColor) :Text(""),

                    ],
                  ),
                ),
              ),
        ),
        const Gap(40),
        Consumer<EventProvider>(
        builder: (_, event, __) =>
          BusyButton(
              title: "Next",
              disabled: imageUrl == null ? true: false,
              onTap: (){
                logger.d(DateFormat("YY-mm-dd H:i:s").format(DateTime.parse(_startDate!)));
                event.createEvent(CreateEventDto(
                    email: _emailController.text.trim(),
                    contact: _phoneController.text.trim(),
                    title: _titleController.text.trim(),
                    thumbnail: imageUrl,
                    description: _summaryController.text.trim(),
                    price: double.parse(_priceController.text.trim() ?? "0"),
                    startsDate: _startDate,
                    endsDate: _endDate,
                    locationType: _isOnline == true ?  "online" : "venue",
                    location: _addressController.text.trim(),
                    countriesPrices: null
                ),
                    context
                );

          }),
        )
      ],
    );
  }
}