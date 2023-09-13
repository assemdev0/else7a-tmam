import 'package:dartz/dartz.dart';
import '../repositories/base_auth_repository.dart';
import '/core/usecase/base_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/failures.dart';
import 'login_with_email_usecase.dart';

class RegisterWithEmailUseCase extends BaseUseCase<User, AuthParams> {
  final BaseAuthRepository _baseAuthRepository;

  RegisterWithEmailUseCase(this._baseAuthRepository);

  @override
  Future<Either<Failure, User>> call(AuthParams params) async {
    return await _baseAuthRepository.registerWithEmail(params);
  }
}
