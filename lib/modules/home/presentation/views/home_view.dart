import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/notification_icon.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/reconmende_job.entity.dart' as REconmendedJobs;
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/single_job.screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key,});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _search = TextEditingController();

  bool _isLoading = false;

  void setSearchLoader(){
    setState(() {
      _isLoading = true;
    });
    FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                          currentFocus.focusedChild?.unfocus();
                        }
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if(mounted){
          setState(() {
            _isLoading = false;
            _search.clear();
          });
        }

      });
    });
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserViewModel>();
    final name = Functions.capitalize(user.authState.user?.name ?? "");
    final splitName = name.split(' ');
    final firstName = splitName[0];
    return Scaffold(
      
      appBar: AppBar(
        elevation: 0,
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
        title: Text(
          'Hi, ${firstName}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 16,
            fontFamily: AppFonts.manRope
          )
        ),
        centerTitle: false,
        actions: [
         const NotificationIcon()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: _search,
                         decoration: textInputDecoration.copyWith(
                            fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.08) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.08) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.1) : const Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                        hintText: "Search",
                              prefixIcon: _isLoading ? Container(margin: const EdgeInsets.only(left:
                              5), height: screenHeight(context) * 0.01, width: screenWidth(context) * 0.01, child: const CircularProgressIndicator(color: AppColors.primaryColor,),)  : Icon(Icons.search, color: Theme.of(context).iconTheme.color,)
                          ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    flex: 1,
                    child: TouchableOpacity(
                      onTap: (){
                        setSearchLoader();

                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:const Icon(Icons.tune_outlined, color: Colors.white,),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              child: TextSemiBold("Reconmended", fontSize: 20, fontWeight: FontWeight.w600,),
            ),
            const Gap(8),
            Consumer<JobProvider>(
              builder: (context, _reconmended, child) {
                return SizedBox(
                  height: 160.h,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _reconmended.reconmendedjobs.length,
                      itemBuilder:(context, index){
                      final data = _reconmended.reconmendedjobs[index];
                        return _jobCard(data);
                      }
                  ),
                );
              }
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: TextSemiBold("Recently Posted", fontSize: 20, fontWeight: FontWeight.w600, style: Theme.of(context).textTheme.titleLarge,),
            ),
           Consumer<JobProvider>(
              builder: (context, job, child) {
              return  job.job.isEmpty && job.jobhState.isGenerating ? const Center(child: CircularProgressIndicator()) : ListView.builder( 
                physics: const NeverScrollableScrollPhysics(),
                
                shrinkWrap: true,
                itemCount: job.job.length > 3 ? 3 : job.job.length,
                itemBuilder:(context, index) {
                  final e = job.job[index];
                  // logger.d(e);
                  return _recentJobCard(e);
                }
             );
              }
            ),
          ],
        ),
      ),
    );
  }
  Widget _jobCard(REconmendedJobs.Recommendation data){
     final image = data.hiringOrganization;
    return GestureDetector(
       onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleJobScreen(data: Datum(baseSalary: BaseSalary(type: data.baseSalary?.type, value: Value(type: data.baseSalary?.value?.type , value: data.baseSalary?.value?.value) ), employmentType: data.employmentType, validThrough: data.validThrough, status: data.status, identifier: Identifier(value: data.identifier?.value, type: data.identifier?.type, name: data.identifier?.name), jobLocation: JobLocation(type: data.jobLocation?.type, 
            address: Address(type: 
            data.jobLocation?.address?.type, streetAddress: data.jobLocation?.address?.streetAddress, addressLocality: data.jobLocation?.address?.addressLocality, addressRegion:data.jobLocation?.address?.addressRegion, postalCode: data.jobLocation?.address?.postalCode, addressCountry: data.jobLocation?.address?.addressCountry)), 
            jobLocationType: data.jobLocationType, createdAt: data.createdAt, updatedAt: data.updatedAt, slug: data.slug,title: data.title, uuid: data.uuid,userUuid: data.userUuid, 
            hiringOrganization: HiringOrganization(type: data.hiringOrganization?.type, name: data.hiringOrganization?.name, sameAs: data.hiringOrganization?.sameAs, logo: data.hiringOrganization?.logo), applicantLocationRequirements: data.applicantLocationRequirements, alts: data.alts, apply: data.apply, description: data.description, directApply: data.directApply, id: data.id, ))
          ),
        );
        },
      child: Container(
        height: 160.h,
        width: 170.w,
        // margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150.w,
              height: 80.h,
              child: image == null ? SvgPicture.asset("assets/images/work-image.svg", fit: BoxFit.cover,) : image.logo == null ?  SvgPicture.asset("assets/images/work-image.svg", fit: BoxFit.cover,) :
           CachedNetworkImage(
            
            imageUrl: image.logo,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SizedBox(width: 30, height:30, child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
          ),
              ),
            const Gap(12),
            Text(data.title.toString(),  style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis,),
            const Gap(8),
             Text(data.baseSalary == null ? "N/A" : data.baseSalary?.value == null && data.baseSalary?.value?.value == null ? "N/A" : Functions.money(double.parse("${data.baseSalary?.value?.value.toString() ?? "0"}"), '\$'),  style: const TextStyle(
                fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xff7B7B7B),
              ),),
          ],
        ),
      ),
    );
  }

   Widget _recentJobCard(Datum data) {
   final image = data.hiringOrganization == null ? null : data.hiringOrganization;
    // logger.d(data.hiringOrganization?.logo);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: ListTile(
        onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleJobScreen(data: data)
          ),
        );
        },
        contentPadding: EdgeInsets.zero,
        leading: image == null ? SvgPicture.asset("assets/images/work-image.svg",) : image.logo == null ?  SvgPicture.asset("assets/images/work-image.svg") :
         CachedNetworkImage(
          imageUrl: "",
          placeholder: (context, url) => const SizedBox(width: 30, height:30, child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
        ),
        title: TextSemiBold(data.title.toString(), fontSize: 14,fontWeight: FontWeight.w600,), subtitle: TextSemiBold(data.hiringOrganization?.name.toString() ?? "Unknown Company", fontSize: 11,color: AppColors.grey, fontWeight: FontWeight.w400,),),
    );
  }
}
