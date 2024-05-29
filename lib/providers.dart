import 'package:analogue_shifts_mobile/app/notifier/app_notifier.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:analogue_shifts_mobile/modules/notification/presentation/notifiers/notification_provider.dart';
import 'package:analogue_shifts_mobile/modules/uploads/presentation/changeNotifiers/upload_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (_) => UserViewModel(),
  ),
  ChangeNotifierProvider(
    create: (_) => JobProvider(),
  ),
  ChangeNotifierProvider(
    create: (_) => AppChangeNotifier()
  ),
   ChangeNotifierProvider(
    create: (_) => FileUploadNotifier()
  ),

  ChangeNotifierProvider(
    create: (_) => NotificationProvider()
  ),

];