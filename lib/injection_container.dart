import 'package:analogue_shifts_mobile/app/notifier/app_notifier.dart';
import 'package:analogue_shifts_mobile/core/navigators/go_router.dart';
import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/network/network_info.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/device_info.dart';
import 'package:analogue_shifts_mobile/core/utils/url_launcher.dart';
import 'package:analogue_shifts_mobile/firebase_handler.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/repositories/auth_repositoryImpl.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/usecases/register.usecase.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/repositories/jobs_repositoryImpl.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/repositories/jobs_repository.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/usecases/fetch_job.usecase.dart';
import 'package:analogue_shifts_mobile/modules/notification/data/repositories/notification_repositoryimpl.dart';
import 'package:analogue_shifts_mobile/modules/notification/domain/repositories/notification_repository.dart';
import 'package:analogue_shifts_mobile/modules/notification/domain/usecases/get_notification_use_cases.dart';
import 'package:analogue_shifts_mobile/modules/uploads/data/repositories/file_repository_impl.dart';
import 'package:analogue_shifts_mobile/modules/uploads/domain/repositories/file_repository.dart';
import 'package:analogue_shifts_mobile/modules/uploads/domain/usecases/file_upload_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
final getIt = GetIt.instance;

Future<void> setupDependencies() async{
  getIt.registerSingleton<DioManager>(DioManager(''));
  getIt.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(getIt<DioManager>()),
  );
  getIt.registerLazySingleton<JobsRepository>(
        () => JobsRepositoryImpl(getIt<DioManager>()),
  );

   getIt.registerLazySingleton<UploadRepository>(
        () => UploadRepositoryImpl(getIt<DioManager>()),
  );


   getIt.registerLazySingleton<NotificationRepository>(
        () => NotificationRepositoryImpl(getIt<DioManager>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
        () => LogoutUseCase(),
  );
  getIt.registerLazySingleton<RegistrationUseCase>(
        () => RegistrationUseCase()
  );

  getIt.registerLazySingleton<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase()
  );

  getIt.registerLazySingleton<VerifyPasswordOtpUseCase>(
        () => VerifyPasswordOtpUseCase()
  );

  getIt.registerLazySingleton<InitiateVerificationUseCase>(
        () => InitiateVerificationUseCase()
  );


  getIt.registerLazySingleton<FetchJobsUseCase>(
        () => FetchJobsUseCase(),
  );

  getIt.registerLazySingleton<UpdateUserUseCase>(
        () => UpdateUserUseCase(),
  );

  getIt.registerLazySingleton<FetchUserUseCase>(
        () => FetchUserUseCase(),
  );

  getIt.registerLazySingleton<UpdatePasswordUseCase>(
        () => UpdatePasswordUseCase(),
  );


  getIt.registerLazySingleton<UploadImageUseCase>(
        () => UploadImageUseCase(),
  );

  getIt.registerLazySingleton<VerifyEmailUseCase>(
        () => VerifyEmailUseCase()
  );

   getIt.registerLazySingleton<FetchNotificationUseCase>(
        () => FetchNotificationUseCase()
  );
  getIt.registerLazySingleton<FetchReconmendedJobsUseCase>(
        () => FetchReconmendedJobsUseCase()
  );

  getIt.registerLazySingleton<ErrorHandler>(
        () => ErrorHandler(),
  );

  getIt.registerLazySingleton<DeviceInfo>(
        () => DeviceInfo(),
  );
  getIt.registerLazySingleton<DeviceNetwork>(
        () => DeviceNetwork(),
  );
  getIt.registerLazySingleton<UrlLauncher>(
        () => UrlLauncher()
  );
   getIt.registerLazySingleton<FirebaseHandler>(
        () => FirebaseHandler()
  );

  getIt.registerSingleton<DBService>(DBService());
  getIt.registerSingleton<AppChangeNotifier>(AppChangeNotifier());
  getIt.registerSingleton<UserViewModel>(UserViewModel());
  await getIt<DBService>().startHive();
  await getIt<AppChangeNotifier>().initAppTheme();
    await getIt<FirebaseHandler>().init();
    await getIt<UserViewModel>().init();
}