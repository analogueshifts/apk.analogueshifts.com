
import 'dart:io';

import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/uploads/domain/entities/upload_response.dart';
import 'package:dartz/dartz.dart';


abstract class UploadRepository {
  Future<Either<Exception, FileUploadDataResponse>> uploadImage(File file);
}