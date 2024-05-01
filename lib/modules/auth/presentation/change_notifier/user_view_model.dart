
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/no_data.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/registration_request_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/verify_password.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/usecases/register.usecase.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/authState.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/change_password.screen.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/user_verification.view.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/verify_user_otp_view.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase = GetIt.instance<LoginUseCase>();
  final InitiateVerificationUseCase _initiateVerifyotpUseCase = GetIt.instance<InitiateVerificationUseCase>();
  final LogoutUseCase _logoutUseCase = GetIt.instance<LogoutUseCase>();
   final RegistrationUseCase _registerUseCase = GetIt.instance<RegistrationUseCase>();
    final ForgotPasswordUseCase _forgetPasswordUseCase = GetIt.instance<ForgotPasswordUseCase>();
      final VerifyPasswordOtpUseCase _verifyFirgetPassWordOtpUseCase = GetIt.instance<VerifyPasswordOtpUseCase>();
  final ErrorHandler _errorHandler = GetIt.instance<ErrorHandler>();
  final _db = getIt<DBService>();
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignIn googleSignIn = GoogleSignIn(
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

  void updateDeviceToken(String value){
    _authState.updateDeviceToken(value);
    notifyListeners();
  }

    Future<void> registerUser(RegisterRequest payload, BuildContext context) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _registerUseCase.call(payload);
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
            await _db.saveToken(user);
            if(context.mounted){
               Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => UserVerificationOtpScreen(email: payload.email)));
            }

      },
    );
    notifyListeners();
  }

   Future<void> forgetPassword(String email, BuildContext context) async {
    toggleGenerating(true);
    notifyListeners();
     _db.clear();
    final result = await _forgetPasswordUseCase(email);
    toggleGenerating(false);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (user) async{
            logger.i('from notifier $user');
            if(user == false) {
              AppSnackbar.error(context, message: "Unable to sent otp");
            }
            if(context.mounted){
              // await AppSnackbar.success(context, message: "OTp sent✅");
                Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => VerifyUserOtpScreen(email: email)));
            }

      },
    );
    notifyListeners();
  }


  Future<void> verifyPasswordOtp(VerifyPasswordEntity payload, BuildContext context) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _verifyFirgetPassWordOtpUseCase(payload);
    toggleGenerating(false);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (user) async{
            logger.i('from notifier $user');
            if(user == false) {
              AppSnackbar.error(context, message: "Unable to verify otp");
            }
            
            if(context.mounted){
                Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ResetChangePasswordScreen(email: payload.email)));
            }

      },
    );
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
              // await AppSnackbar.success(context, message: "Login Successful✅");
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
    toggleGenerating(true);
    final response = await _logoutUseCase.call();
    response.fold((l) {
      toggleGenerating(false);
      var error = _errorHandler.handleError(l);
      if(error == 'Unauthenticated.'){
        _db.clear();
        if(context.mounted){
          
          context.replace(Routes.authenticate);
          AppSnackbar.error(context, message: error);
          // context.pop(context);
          return false;
        }
      }
      if(context.mounted){
        AppSnackbar.error(context, message: error);
      }

    }, (r) async{
      toggleGenerating(false);
      logger.d(r);
      if(context.mounted){
         _db.clear();
        context.replace(Routes.authenticate);
        // context.pop(context);
      }
      return true;
    });
    return false;
  }

  Future<void> initateUserVerification(BuildContext context) async{
    toggleGenerating(true);
    final response = await _initiateVerifyotpUseCase.call();
    response.fold((l) {
      toggleGenerating(false);
      var error = _errorHandler.handleError(l);
      if(error == 'Unauthenticated.'){
        _db.clear();
        if(context.mounted){
          
          context.replace(Routes.authenticate);
          AppSnackbar.error(context, message: error);
        }
      }
      if(context.mounted){
        AppSnackbar.error(context, message: error);
      }

    }, (r) async{
      toggleGenerating(false);
      logger.d(r);
      AppSnackbar.success(context, message: r.message.toString());
      context.replace(Routes.authenticate);
    });
  }
}