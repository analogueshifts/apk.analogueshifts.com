import 'dart:io';

import 'package:analogue_shifts_mobile/modules/uploads/domain/entities/upload_response.dart';
import 'package:analogue_shifts_mobile/modules/uploads/domain/repositories/file_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

class UploadImageUseCase {
  final UploadRepository _fileRepository = GetIt.instance<UploadRepository>();


  Future<Either<Exception, FileUploadDataResponse>> call(File file) async {
    return await _fileRepository.uploadImage(file);
  }
}