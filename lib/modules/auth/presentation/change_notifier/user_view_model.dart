
import 'package:analogue_shifts_mobile/app/widgets/loading_dailog.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/update_user_request.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/forgetpaasswordcreate.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/registration_request_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/verify_password.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/usecases/register.usecase.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/authState.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/auth_success.screen.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/authenticate_view.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/change_password.screen.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/user_verification.view.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/verify_user_otp_view.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/widgets/prompt_to_verify_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
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
   final UpdateUserUseCase _updateUserUseCase = GetIt.instance<UpdateUserUseCase>();
  final FetchUserUseCase _fetchUserUseCase = GetIt.instance<FetchUserUseCase>();
  final UpdatePasswordUseCase _updatePasswordUserUseCase = GetIt.instance<UpdatePasswordUseCase>();
  final VerifyEmailUseCase _verifyEmailUseCase = GetIt.instance<VerifyEmailUseCase>();
    final DeleteAccountUseCase _deleteJobUseCase = GetIt.instance<DeleteAccountUseCase>();

  final _db = getIt<DBService>();
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  final AuthState _authState = AuthState();

  AuthState get authState => _authState;

  bool _isPromptToVerify = false;

  bool get PromptToVerify => _isPromptToVerify;



  init() async{
    final savedUser = await _db.getUser();
    logger.w(savedUser);
    if(savedUser != null){
      _authState.updateUser(savedUser);
      notifyListeners();
    }
    notifyListeners();
  }

  void toggleGenerating(bool value) {
    if(authState.isGenerating == value)return;
    _authState.toggleGenerating();
    notifyListeners();
  }


  void saveUser(User value){
    logger.w(value);
    _authState.updateUser(value);
    _db.saveUser(value);
    notifyListeners();
  }

  void updateDeviceToken(String value){
    _authState.updateDeviceToken(value);
    notifyListeners();
  }

    Future<void> registerUser(RegisterRequest payload, BuildContext context) async {
    showLoadingDialog(context: context);
    final result = await _registerUseCase.call(payload);
    Navigator.pop(context);
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
            logger.d(exception);
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
            toggleGenerating(false);
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (user) async{
            toggleGenerating(false);
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
    showLoadingDialog(context: context);
    final result = await _loginUseCase(user);
    Navigator.pop(context);
    result.fold(
          (exception) {
            toggleGenerating(false);
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (token) async{
            toggleGenerating(false);
            logger.i('Login successful: $user');
            if(token == null) {
              AppSnackbar.error(context, message: "Login failed");
            }else{
              await _db.saveToken(token);
                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        HomeNavigation()),
               (Route<dynamic> route) => false);

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
    var  profile = await googleSignInAccount.displayName;
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
     
        _db.removeAuthToken();
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
      if (context.mounted) {
        AppSnackbar.success(context, message: r.message.toString());
      }
      
    });
  }

   Future<void> updateUser(UpdateUserDto user, BuildContext context) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _updateUserUseCase.call(user);
    toggleGenerating(false);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (user) async{
            logger.i('Update successful: $user');
            await fetchUser(context);
            AppSnackbar.success(context, message: "Update Successful!");
            notifyListeners();
      },
    );
    notifyListeners();
  }


  Future<void> fetchUser(BuildContext context) async {
    logger.d('<<<<!!!>>>>>');

    final result = await _fetchUserUseCase.call();
   
    result.fold(
          (exception) {
        
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (user) async{
            logger.i('Update successful: $user');
            await _db.saveUser(user);
            if(user.user?.emailVerifiedAt == null && _isPromptToVerify == false){
              //TODO: add bootm sheeet
              promptToVerify(context);
            }
            saveUser(user);
            notifyListeners();
      },
    );
    notifyListeners();
  }

    Future<void> verifyUser(BuildContext context, String otp) async {
      logger.d(otp);
          toggleGenerating(true);
    final result = await _verifyEmailUseCase.call(otp);
     

    result.fold(
      
          (exception) {
            toggleGenerating(false);
            logger.d(exception);
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (user) async{
            toggleGenerating(false);
            logger.i('Verified successful: $user');
            await _db.saveUser(user);
            saveUser(user);  
            if(context.mounted){
                 Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const AuthSuccessScreen(title: "Verified!", subtTitle: "Your account has been verified successfully")),
             (Route<dynamic> route) => false);
            }
            notifyListeners();
      },
    );
    notifyListeners();
  }

   Future<void> updatePassword(CreateForgetNewPasswordEntity payload, BuildContext context) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _updatePasswordUserUseCase.call(payload);
    toggleGenerating(false);
    result.fold(
      
          (exception) {
            toggleGenerating(false);
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (r) async{
            toggleGenerating(false);
            logger.i('Update successful: $r');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AuthSuccessScreen(title: "Password Changed", subtTitle: "Your password has been changed successfully",)),
            );
            notifyListeners();
      },
    );
    notifyListeners();
  }


  Future<bool> deleteorDisableUser(BuildContext context, bool isDelete, String password, String reason) async{
    toggleGenerating(true);
    final response = await _deleteJobUseCase.call(isDelete, password, reason);
    response.fold((l) {
      toggleGenerating(false);
      var error = _errorHandler.handleError(l);
      if(error == 'Unauthenticated.'){
        _db.clear();
        if(context.mounted){
           Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      HomeNavigation()),
             (Route<dynamic> route) => false);
          
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
      Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const Authenticate()),
             (Route<dynamic> route) => false);
        _db.removeAuthToken();
        
      return true;
    });
    return false;
  }


  void promptToVerify(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder:(context) {
          return PromptVerifyBottomSheet();

        }
    );
    _isPromptToVerify = true;
    notifyListeners();
  }

}