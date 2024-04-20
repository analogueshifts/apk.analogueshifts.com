
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/usecases/register.usecase.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/authState.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase = GetIt.instance<LoginUseCase>();
  final LogoutUseCase _logoutUseCase = GetIt.instance<LogoutUseCase>();
  final ErrorHandler _errorHandler = GetIt.instance<ErrorHandler>();
  final _db = getIt<DBService>();
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignIn googleSignIn = GoogleSignIn(
    // clientId: '1049258121048-6rja5rf838ch3sahc9gqf4bpj4rpt6j6.apps.googleusercontent.com',
    scopes: [
      'email',
    ],
  );

  final AuthState _authState = AuthState();

  AuthState get authState => _authState;

  void toggleGenerating(bool value) {
    if(authState.isGenerating == value)return;
    _authState.toggleGenerating();
    notifyListeners();
  }


  Future<void> loginUser(LoginUser user, BuildContext context) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _loginUseCase(user);
    toggleGenerating(false);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (user) async{
            logger.i('Login successful: $user');
            if(user.token == null) {
              AppSnackbar.error(context, message: "Login failed");
            }
            await _db.saveToken(user.token.toString());
            if(context.mounted){
              await AppSnackbar.success(context, message: "Login Successful✅");
              context.replace(Routes.homeNavigation);
            }

      },
    );
    notifyListeners();
  }

  Future continueWithGoogle(BuildContext context) async {
    logger.d("runnnning google auth");
    toggleGenerating(true);
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    GoogleSignInAuthentication auth = await googleSignInAccount!.authentication;
    var  profile = await googleSignInAccount!.displayName;
    logger.d(auth.accessToken);
    logger.d(profile);
    toggleGenerating(false);
    notifyListeners();
  }

  Future<bool> logoutUser(BuildContext context) async{
    final response = await _logoutUseCase.call();
    response.fold((l) {
      var error = _errorHandler.handleError(l);
      if(error == 'Unauthenticated.'){
        _db.clear();
        if(context.mounted){
          
          // context.replace(Routes.authenticate);
          AppSnackbar.error(context, message: error);
          // context.pop(context);
          return false;
        }
      }
      if(context.mounted){
        AppSnackbar.error(context, message: error);
      }

    }, (r) async{
      logger.d(r);

      _db.clear();
      if(context.mounted){
        // context.replace(Routes.authenticate);
        // context.pop(context);
      }
      return true;
    });
    return false;
  }
}