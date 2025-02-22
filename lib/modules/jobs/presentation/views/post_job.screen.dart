// import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
// import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
// import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/add_company.screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';

// class PostJobScreen extends StatefulWidget {
//   const PostJobScreen({super.key});

//   @override
//   State<PostJobScreen> createState() => _PostJobScreenState();
// }

// class _PostJobScreenState extends State<PostJobScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
//     return Scaffold(
//       body: Padding(
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Gap(10),
//               SvgPicture.asset("assets/images/Frame 482339.svg"),
//               Gap(35),
//               TextSemiBold("No jobs posted yet", fontSize: 18, fontWeight: FontWeight.w500, color: isLight ? AppColors.background : AppColors.white),
//               Gap(10),
//               TextSemiBold("Click the button at the bottom to post a job.", fontSize: 14, color: Color(0xff666666),),
//               Gap(45),
//               InkWell(
//                 onTap: (){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => AddCompanyScreen()
//                     ),
//                   );
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                           color: AppColors.primaryColor
//                       )
//                   ),
//                   child: TextSemiBold("Add company", color: AppColors.white, fontWeight: FontWeight.w700, textAlign: TextAlign.center,),
//                 ),
//               ),
//               Gap(20),
//               // InkWell(
//               //   onTap: (){
//               //     Navigator.push(
//               //       context,
//               //       MaterialPageRoute(
//               //           builder: (context) => PostAJobScreen()
//               //       ),
//               //     );
//               //   },
//               //   child: Container(
//               //     padding: EdgeInsets.symmetric(vertical: 16),
//               //     width: double.infinity,
//               //     decoration: BoxDecoration(
//               //       borderRadius: BorderRadius.circular(10),
//               //       border: Border.all(
//               //         color: AppColors.primaryColor
//               //       )
//               //     ),
//               //     child: TextSemiBold("Post a job", color: AppColors.primaryColor, fontWeight: FontWeight.w700, textAlign: TextAlign.center,),
//               //   ),
//               // )

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/filter_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'add_company.screen.dart';
import 'post_a_job.screen.dart';

class PostJobScreen extends StatelessWidget {
  const PostJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: _JobsContent(),
        );
      },
    );
  }
}

class _JobsContent extends StatefulWidget {
  const _JobsContent();

  @override
  State<_JobsContent> createState() => _JobsContentState();
}

class _JobsContentState extends State<_JobsContent> {
  final List<String> _filters = ["All", "Drafts", "Jobs posted", "Companies"];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SearchField(),
        const SizedBox(height: 25),
        const _JobCompanyButtons(),
        const SizedBox(height: 25),
        FilterChips(
          filters: _filters,
          selectedIndex: _selectedIndex,
          onSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        const SizedBox(height: 20),
        // The _JobsList widget receives the selected filter.
        Expanded(child: _JobsList(filter: _filters[_selectedIndex])),
      ],
    );
  }
}

/// Search field for jobs and companies.
class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search for posted jobs & companies added",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}

/// Two cards for "Post a Job" and "Add Company".
class _JobCompanyButtons extends StatelessWidget {
  const _JobCompanyButtons();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context).width;
    return Row(
      children: [
        // "Post a Job" card
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostAJobScreen(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 100,
                //color: AppColors.primaryColor,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/icons/add_job_card.svg",
                  width: size * 0.5,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // "Add Company" card
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCompanyScreen(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 100,
                //color: AppColors.primaryColor,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/icons/add_company.svg",
                  width: size * 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



/// A dynamically built list displaying individual job items with a header title.
class _JobsList extends StatelessWidget {
  final String filter;
  const _JobsList({required this.filter});

  /// Returns a header title based on the currently selected filter.
  String get headerTitle {
    switch (filter) {
      case "All":
        return "All activities";
      case "Drafts":
        return "Drafts";
      case "Jobs posted":
        return "Jobs posted";
      case "Companies":
        return "Companies";
      default:
        return "";
    }
  }

  /// Dummy job data to simulate database records.
  List<Map<String, dynamic>> get jobData => [
        {
          'title': "Mid-level Security Analyst",
          'subtitle': "Hostshifts",
          'isDraft': true,
        },
        {
          'title': "UI/UX Designer",
          'subtitle': "Cowrywise",
          'isDraft': false,
        },
        {
          'title': "Backend Developer",
          'subtitle': "Hostshifts",
          'isDraft': false,
        },
        {
          'title': "Frontend Developer",
          'subtitle': "Cowrywise",
          'isDraft': false,
        },
      ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // +1 for the header.
      itemCount: jobData.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          // Header displaying the title based on the selected filter.
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(headerTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
          );
        }
        final job = jobData[index - 1];
        return _JobListItem(
          title: job['title'] as String,
          subtitle: job['subtitle'] as String,
          isDraft: job['isDraft'] as bool,
        );
      },
    );
  }
}

/// A widget representing an individual job list item.
class _JobListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDraft;

  const _JobListItem({
    required this.title,
    required this.subtitle,
    this.isDraft = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        "assets/icons/company_placeholder.svg",
        width: 40,
        height: 40,
      ),
      title: TextSemiBold(
        title,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      subtitle: Row(
        children: [
          TextSemiBold(
            subtitle,
            fontSize: 12,
            color: AppColors.grey,
            fontWeight: FontWeight.w400,
          ),
          // if (isDraft)
          //   Padding(
          //     padding: const EdgeInsets.only(left: 8.0),
          //     child: Chip(
          //       label: const Text("Drafts", style: TextStyle(fontSize: 12)),
          //       backgroundColor: Colors.amber.shade100,
          //     ),
          //   ),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
