import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/notification_icon.dart';
import 'package:analogue_shifts_mobile/modules/vetting/presentation/widgets/no_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VettingSystemScreen extends StatefulWidget {
  const VettingSystemScreen({super.key});

  @override
  State<VettingSystemScreen> createState() => _VettingSystemScreenState();
}

class _VettingSystemScreenState extends State<VettingSystemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: TouchableOpacity(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
              width: 20, height: 20,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: const Icon(Icons.menu)
          ),
        ),
        title: TextBold("Vetting System", fontSize: 20, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
        centerTitle: true,
        actions: [
          const NotificationIcon()
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListView(
          children: [
            Table(
              // border: TableBorder.all(color: Colors.black),
              children: [
                  
                TableRow(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff56669F).withOpacity(0.06) : const Color(0xff2A261F)
                  ),
                  children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 0, 20),
                    child: Text('Name'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text('Date'),
                  ),
                  Padding(
                     padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text('Duration'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                    child: Text('Action'),
                  )
                ]),
               
              ],
            ),
            SizedBox(height: 100.h,),
            const Center(child: NoItemVetting())
          ],
        ),
      ),
    );
  }
}