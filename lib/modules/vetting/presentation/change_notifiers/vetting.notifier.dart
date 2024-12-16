import 'dart:io';
import 'package:analogue_shifts_mobile/app/widgets/loading_dailog.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/utils/disposable_provider.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/modules/uploads/domain/usecases/file_upload_usecase.dart';
import 'package:analogue_shifts_mobile/modules/vetting/data/models/form.model.dart';
import 'package:analogue_shifts_mobile/modules/vetting/data/repositories/vetting_form.repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class VettingNotifier extends DisposableProvider {
  final VettingRepositoryImpl _vettingRepo = GetIt.instance<VettingRepositoryImpl>();
  final ErrorHandler _errorHandler = GetIt.instance<ErrorHandler>();
  FormEntity? _form;
  FormEntity? get image => _form;

  List<FormEntity?> _forms = [];
  List<FormEntity?> get forms => _forms;

  bool? _isUploading;
  bool? get isUploading => _isUploading;

  String? _uploadedImage;


  String? get uploadedImage => _uploadedImage;

  void setLoader(bool value){
    _isUploading = value;
    notifyListeners();
  }

  void setUploadedImage(String image){
    _uploadedImage = image;
    notifyListeners();
  }
  Future<void> createForm(BuildContext context, dynamic payload) async {
    showLoadingDialog(context: context);
      final upload = await _vettingRepo.createForm(payload);
      Navigator.pop(context);
      upload.fold(
              (exception){
            var error = _errorHandler.handleError(exception);
            if(context.mounted){
              AppSnackbar.error(context, message: error);
            }
          },
              (result) async {
                // _form = result;
            logger.d(result);
            notifyListeners();
          }
      );
      notifyListeners();

  }

  Future<void> getAllForm(BuildContext context) async {
    setLoader(true);
    final upload = await _vettingRepo.getAllForm();
    setLoader(false);
    upload.fold(
            (exception){
          var error = _errorHandler.handleError(exception);
          if(context.mounted){
            AppSnackbar.error(context, message: error);
          }
        },
            (result) async {
              _forms.addAll(result.toList());
          // _form = result;
          logger.d(result);
          notifyListeners();
        }
    );
    notifyListeners();

  }
  @override
  void disposeValues() {
    _form = null;
  }
}