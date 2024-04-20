import 'package:analogue_shifts_mobile/app/notifier/app_notifier.dart';
import 'package:analogue_shifts_mobile/core/navigators/go_router.dart';
import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/repositories/auth_repositoryImpl.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/usecases/register.usecase.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/repositories/jobs_repositoryImpl.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/repositories/jobs_repository.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/usecases/fetch_job.usecase.dart';
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

  getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
        () => LogoutUseCase(),
  );
  getIt.registerLazySingleton<FetchJobsUseCase>(
        () => FetchJobsUseCase(),
  );

  getIt.registerLazySingleton<ErrorHandler>(
        () => ErrorHandler(),
  );
  getIt.registerSingleton<GoRouter>(AppRoutes().router);
  getIt.registerSingleton<DBService>(DBService());
  await getIt<DBService>().startHive();

    getIt.registerSingleton<AppChangeNotifier>(AppChangeNotifier());
    await getIt<AppChangeNotifier>().initAppTheme();

}