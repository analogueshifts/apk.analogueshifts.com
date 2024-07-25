import 'dart:io';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/utils/disposable_provider.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/modules/uploads/domain/usecases/file_upload_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadNotifier extends DisposableProvider {
  final UploadImageUseCase _uploadFileUseCase = GetIt.instance<UploadImageUseCase>();
  final ErrorHandler _errorHandler = GetIt.instance<ErrorHandler>();
   File? _image;
   File? get image => _image;

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
    Future<void> openImagePicker(BuildContext context) async {
     _uploadedImage = null;
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (image != null) {
      _image = File(image.path);
      logger.d(image.path);
      setLoader(true);
      final upload = await _uploadFileUseCase.call(File(image.path));
      setLoader(false);
      upload.fold(
        (exception){
           var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }
        },
        (result) async {
          if (result.baseUrl == null && result.path == null)return;
          _uploadedImage = '${result.baseUrl!}/${result.path!}';
          logger.d(_uploadedImage);
          notifyListeners();
        }
        );
      notifyListeners();   
    }
  }
  
  @override
  void disposeValues() {
    _image = null;
  }
}