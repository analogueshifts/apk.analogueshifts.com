
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
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

  init(){
    final user = _db.getUser(0);
    logger.d('fetch from cache ${user?.email}');
    logger.e("running PP FUNXTION");
    if (user == null) return;
    final dbUser = user;
    saveUser(User(phoneNoCode: dbUser.phoneNoCode, phoneNo: dbUser.phoneNo, status: dbUser.status, id: dbUser.id, deviceType: dbUser.deviceType, deviceToken: dbUser.deviceToken, uuid: dbUser.uuid, firstName: dbUser.firstName,lastName: dbUser.lastName, username: dbUser.username, email: dbUser.email, tel: dbUser.tel, userType: dbUser.userType, profile: dbUser.profile, otp: dbUser.otp, isVerified: dbUser.isVerified,emailVerifiedAt: dbUser.emailVerifiedAt, createdAt: dbUser.createdAt, updatedAt: dbUser.updatedAt));
    logger.i(_authState.user);
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
    toggleGenerating(true);
    notifyListeners();
    final result = await _loginUseCase(user);
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
            logger.i('Login successful: $user');
            if(user.data?.token == null) {
              AppSnackbar.error(context, message: "Login failed");
            }else{
              if (user.data == null) {
                AppSnackbar.error(context, message: "Login failed");
              }else{
                 await _db.saveToken(user.data!.token.toString());
            if (user.data?.user != null) {
              saveUser(user.data!.user!);
              _db.saveUser(user.data!.user!);
            }
            
            if(context.mounted){
              // await AppSnackbar.success(context, message: "Login Successful✅");
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const HomeNavigation()),
             (Route<dynamic> route) => false);
            }
              }
             
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
        _db.removeUser(0);
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

   Future<void> updateUser(User user, BuildContext context) async {
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
            saveUser(user);
            _db.saveUser(user);
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
                      const HomeNavigation()),
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
        _db.removeUser(0);
        
      return true;
    });
    return false;
  }

}