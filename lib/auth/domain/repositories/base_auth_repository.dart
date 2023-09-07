import 'package:dartz/dartz.dart';
import 'package:else7a_tamam/core/usecase/base_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/failures.dart';
import '../use_cases/login_with_email_usecase.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, User>> loginWithEmail(AuthParams params);
  Future<Either<Failure, User>> registerWithEmail(AuthParams params);
  Future<Either<Failure, NoParams>> logout();
}
